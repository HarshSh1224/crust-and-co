import 'package:dio/dio.dart';
import 'package:user_repository/src/api/api.dart';
import 'package:user_repository/src/api/api_exception.dart';
import 'package:user_repository/src/api/api_routes.dart';
import 'package:user_repository/src/constants/repo_constants.dart';
import 'package:user_repository/src/constants/repo_language.dart';
import 'package:user_repository/src/models/user_model.dart';
import 'package:user_repository/src/shared_prefs/shared_preferences.dart';
import 'package:user_repository/src/user_repo.dart';

class DatabaseUserRepo implements UserRepository {
  MyUser? _myUser;
  String? _accessToken;
  String? _refreshToken;

  final Api _api = Api();

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      final response = await _api.sendRequest.post(ApiRoutes.login, data: {
        RepoConstants.email: email,
        RepoConstants.password: password,
      });

      if (response.statusCode == 200) {
        await DevicePreferences.setAccessToken(
            response.data[RepoConstants.data][RepoConstants.accessToken]);
        await DevicePreferences.setRefreshToken(
            response.data[RepoConstants.data][RepoConstants.refreshToken]);
        _myUser = MyUser.fromMap(
            response.data[RepoConstants.data][RepoConstants.user]);
        _accessToken =
            response.data[RepoConstants.data][RepoConstants.accessToken];
        _refreshToken =
            response.data[RepoConstants.data][RepoConstants.refreshToken];
        return true;
      } else {
        throw ApiException(
            message:
                response.data[RepoConstants.message] ?? response.statusMessage,
            code: response.statusCode);
      }
    } on DioException catch (e) {
      throw ApiException(
          message: e.response?.data[RepoConstants.message] ??
              e.response?.statusMessage ??
              (e.type.name.contains('Timeout')
                  ? RepoLanguage.connectionTimeout
                  : null),
          code: e.response?.statusCode);
    }
  }

  @override
  Future<bool> signUp(MyUser myUser, String password) async {
    try {
      final response = await _api.sendRequest.post(ApiRoutes.register, data: {
        RepoConstants.email: myUser.email,
        RepoConstants.password: password,
        RepoConstants.fullName: myUser.fullName,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ApiException(
            message:
                response.data[RepoConstants.message] ?? response.statusMessage,
            code: response.statusCode);
      }
    } on DioException catch (e) {
      throw ApiException(
          message: e.response?.data[RepoConstants.message] ??
              e.response?.statusMessage ??
              (e.type.name.contains('Timeout')
                  ? RepoLanguage.connectionTimeout
                  : null),
          code: e.response?.statusCode);
    }
  }

  @override
  Future<bool> trySignIn([bool canRefreshToken = true]) async {
    print('trying signin');
    _accessToken = await DevicePreferences.getAccessToken();
    _refreshToken = await DevicePreferences.getRefreshToken();

    if (_accessToken != null && _refreshToken != null) {
      print('getting current user');
      try {
        final response = await _api.sendRequest.get(
          ApiRoutes.currentUser,
          options: Options(
            headers: {"Authorization": "Bearer $_accessToken"},
          ),
        );

        if (response.statusCode == 200) {
          _myUser = MyUser.fromMap(response.data[RepoConstants.data]);
          return true;
        } else {
          print('err');
          print(response.data[RepoConstants.message] ?? response.statusMessage);
        }
      } on DioException catch (e) {
        try {
          if (e.response?.statusCode != null &&
              e.response!.statusCode! ~/ 100 == 4 &&
              canRefreshToken) {
            final response = await _api.sendRequest.post(ApiRoutes.refreshToken,
                data: {RepoConstants.refreshToken: _refreshToken});

            if (response.statusCode == 200) {
              await DevicePreferences.setAccessToken(
                  response.data[RepoConstants.data][RepoConstants.accessToken]);
              await DevicePreferences.setRefreshToken(response
                  .data[RepoConstants.data][RepoConstants.refreshToken]);

              return trySignIn(false);
            }
          } else {
            print(e.message);
          }
        } on DioException catch (e) {
          print(e.response?.data[RepoConstants.message] ??
              e.response?.statusMessage ??
              (e.type.name.contains('Timeout')
                  ? RepoLanguage.connectionTimeout
                  : null));
        }
      }
    }
    _myUser = MyUser.empty;
    return false;
  }

  @override
  Future<void> signOut() async {
    await DevicePreferences.setAccessToken("");
    await DevicePreferences.setRefreshToken("");
    _myUser = MyUser.empty;
  }

  @override
  MyUser get currentUser => _myUser ?? MyUser.empty;
}

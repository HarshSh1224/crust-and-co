import 'package:dio/dio.dart';
import 'package:user_repository/src/api/api.dart';
import 'package:user_repository/src/api/api_exception.dart';
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
      final response = await _api.sendRequest.post('users/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        await DevicePreferences.setAccessToken(
            response.data['data']['accessToken']);
        await DevicePreferences.setRefreshToken(
            response.data['data']['refreshToken']);
        _myUser = MyUser.fromMap(response.data['data']['user']);
        _accessToken = response.data['data']['accessToken'];
        _refreshToken = response.data['data']['refreshToken'];
        return true;
      } else {
        throw ApiException(
            message: response.data['message'] ?? response.statusMessage,
            code: response.statusCode);
      }
    } on DioException catch (e) {
      throw ApiException(
          message: e.response?.data['message'] ??
              e.response?.statusMessage ??
              (e.type.name.contains('Timeout') ? 'Connection Timeout' : null),
          code: e.response?.statusCode);
    }
  }

  @override
  Future<bool> signUp(MyUser myUser, String password) async {
    try {
      final response = await _api.sendRequest.post('users/register', data: {
        'email': myUser.email,
        'password': password,
        'fullName': myUser.fullName,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ApiException(
            message: response.data['message'] ?? response.statusMessage,
            code: response.statusCode);
      }
    } on DioException catch (e) {
      throw ApiException(
          message: e.response?.data['message'] ??
              e.response?.statusMessage ??
              (e.type.name.contains('Timeout') ? 'Connection Timeout' : null),
          code: e.response?.statusCode);
    }
  }

  @override
  Future<bool> trySignIn() async {
    _accessToken = await DevicePreferences.getAccessToken();
    _refreshToken = await DevicePreferences.getRefreshToken();

    print(_accessToken);

    if (_accessToken != null && _refreshToken != null) {
      try {
        final response = await _api.sendRequest.get(
          'users/current-user',
          options: Options(
            headers: {"Authorization": "Bearer $_accessToken"},
          ),
        );

        if (response.statusCode == 200) {
          _myUser = MyUser.fromMap(response.data['data']);
          return true;
        } else {
          print(response.data['message'] ?? response.statusMessage);
          // throw ApiException(
          //     message: response.data['message'] ?? response.statusMessage,
          //     code: response.statusCode);
        }
      } on DioException catch (e) {
        print(e.response?.data['message'] ??
            e.response?.statusMessage ??
            (e.type.name.contains('Timeout') ? 'Connection Timeout' : null));
        // throw ApiException(
        //     message: e.response?.data['message'] ??
        //         e.response?.statusMessage ??
        //         (e.type.name.contains('Timeout') ? 'Connection Timeout' : null),
        //     code: e.response?.statusCode);
      }
    }
    _myUser = MyUser.empty;
    return false;
  }

  @override
  MyUser get currentUser => _myUser ?? MyUser.empty;
}

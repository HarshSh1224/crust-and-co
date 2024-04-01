import 'package:dio/dio.dart';
import 'package:user_repository/src/api/api.dart';
import 'package:user_repository/src/api/api_exception.dart';
import 'package:user_repository/src/models/user_model.dart';
import 'package:user_repository/src/user_repo.dart';

class DatabaseUserRepo implements UserRepository {
  MyUser? _myUser;

  final Api _api = Api();

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      final response = await _api.sendRequest.post('users/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        _myUser = MyUser.fromMap(response.data['data']['user']);
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
    Future.delayed(const Duration(seconds: 2));
    _myUser = MyUser.empty;
    return false;
  }

  @override
  MyUser get currentUser => _myUser ?? MyUser.empty;
}

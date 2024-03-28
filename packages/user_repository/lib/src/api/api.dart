import 'package:dio/dio.dart';

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = 'http://10.41.22.242:8080/';
    _dio.options.connectTimeout = const Duration(seconds: 15);
  }

  Dio get sendRequest => _dio;
}

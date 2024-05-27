import 'package:dio/dio.dart';

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = 'http://192.168.18.45:8080/';
  }

  Dio get sendRequest => _dio;
}

import 'package:dio/dio.dart';

class DioFactory {
  final Dio _dio;

  DioFactory(this._dio);

  getDio() {
    _dio
      ..options.baseUrl = 'https://api.github.com'
      ..options.connectTimeout = const Duration(milliseconds: 5000)
      ..options.receiveTimeout = const Duration(milliseconds: 3000)
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
  }
}

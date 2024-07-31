import 'package:dio/dio.dart';

class DioFactory {
  Dio getDio() {
    return Dio()
      ..options.baseUrl = 'https://api.github.com'
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 5)
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': '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',
      
      }
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
  }
} 

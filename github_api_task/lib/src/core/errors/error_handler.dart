// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:github_api_task/src/core/errors/exceptions.dart';
import 'package:github_api_task/src/core/errors/failures.dart';


abstract class ErrorHandler {
  static AppException handleException(dynamic error) {
    if (error is DioException) {
      return getCustomExceptionBasedOnDioException(error);
    } else if (error is AppException) {
      return error;
    } else {
      return CustomException();
    }
  }

  static AppException getCustomExceptionBasedOnDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        return NoInternetException();
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeOutException();
      default:
        return ServerException();
    }
  }

  static Failure _getFailureFromException(AppException exception) => exception.failure;

  static Failure handleError(dynamic error) {
    final exception = handleException(error);
    return _getFailureFromException(exception);
  }

}

import 'package:github_api_task/src/core/errors/failures.dart';


abstract class AppException implements Exception {
  Failure get failure;
}

class NoInternetException implements AppException {
  @override
  Failure get failure => const NoInternetFailure();
}

class ServerException implements AppException {
  @override
  Failure get failure => const ServerFailure();
}

class TimeOutException implements AppException {
  @override
  Failure get failure => const TimeoutFailure();
}

class GetLocalDataException implements AppException {
  @override
  Failure get failure => const GetLocalDataFailure();
}
class AddLocalDataException implements AppException {
  @override
  Failure get failure => const AddLocalDataFailure();
}
class DeleteLocalDataException implements AppException {
  @override
  Failure get failure => const DeleteLocalDataFailure();
}


class CustomException implements AppException {
  @override
  Failure get failure => const CustomFailure();
}

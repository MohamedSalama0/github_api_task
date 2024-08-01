abstract class Failure {

  final String? error;

 const Failure([this.error]);

  String get failMsg;

  @override
  String toString() => 'Failure: $failMsg';

  

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class NoInternetFailure extends Failure {
  const NoInternetFailure([super.error]);

  @override
  String get failMsg => error ?? 'No internet connection!';
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.error]);

  @override
  String get failMsg => error ?? 'Server timeout!';
}
class GetLocalDataFailure extends Failure {
  const GetLocalDataFailure([super.error]);

  @override
  String get failMsg => error ?? 'Error in get local data!';
}
class AddLocalDataFailure extends Failure {
  const AddLocalDataFailure([super.error]);

  @override
  String get failMsg => error ?? 'Error in add local data!';
}
class DeleteLocalDataFailure extends Failure {
  const DeleteLocalDataFailure([super.error]);

  @override
  String get failMsg => error ?? 'Error in delete local data!';
}

class ServerFailure extends Failure {
  const ServerFailure([super.error]);

  @override
  String get failMsg => error ?? 'Failed to connect to the server!';
}


class CustomFailure extends Failure {
  const CustomFailure([super.error]);

  @override
  String get failMsg => error ?? 'Something went wrong!';
}

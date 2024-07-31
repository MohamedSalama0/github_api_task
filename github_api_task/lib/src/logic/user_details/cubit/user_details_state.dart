part of 'user_details_cubit.dart';
@immutable
sealed class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object> get props => [];
}


class UserDetailsLoading extends UserDetailsState {
  const UserDetailsLoading();
}

class UserDetailsLoaded extends UserDetailsState {
  final GithubUser user;

  const UserDetailsLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class UserDetailsError extends UserDetailsState {
  final String message;
  const UserDetailsError(this.message);
  @override
  List<Object> get props => [message];
}


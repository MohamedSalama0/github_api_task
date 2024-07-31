part of 'github_user_cubit.dart';

@immutable
sealed class GithubUserState extends Equatable {
  const GithubUserState();

  @override
  List<Object> get props => [];
}

class GithubUserInitial extends GithubUserState {
  const GithubUserInitial();
}

class GithubUserFollowersLoading extends GithubUserState {
  const GithubUserFollowersLoading();
}

class LoadingMoreFollowers extends GithubUserState {
  const LoadingMoreFollowers();
}

class GithubUserFollowersLoaded extends GithubUserState {
  final List<Follower> followers;
  final bool hasReachedMax;

  const GithubUserFollowersLoaded({required this.followers, required this.hasReachedMax});
  @override
  List<Object> get props => [followers, hasReachedMax];
}

class GithubUserFollowersError extends GithubUserState {
  final String message;
  const GithubUserFollowersError(this.message);
  @override
  List<Object> get props => [message];
}

class GithubUserError extends GithubUserState {
  final String message;

  const GithubUserError(this.message);

  @override
  List<Object> get props => [message];
}

class GithubUserInfoLoading extends GithubUserState {
  const GithubUserInfoLoading();
}

class GithubUserInfoLoaded extends GithubUserState {
  final GithubUser userInfo;
  const GithubUserInfoLoaded(this.userInfo);
  @override
  List<Object> get props => [userInfo];
}

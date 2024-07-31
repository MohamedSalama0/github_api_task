import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:github_api_task/src/logic/repositories/github_user_repo.dart';
import 'package:github_api_task/src/models/follower_model.dart';
import 'package:github_api_task/src/models/github_user_model.dart';

part 'github_user_state.dart';

class GithubUserCubit extends Cubit<GithubUserState> {
  GithubUserCubit(this.repository) : super(const GithubUserInitial());
  final GithubUserRepository repository;
  String _currentQuery = '';
  int _currentPage = 1;

  Future<void> getUserFollowers(String username, int page) async {
    emit(const GithubUserFollowersLoading());

    _currentQuery = username;
    _currentPage = 1;
    final result = await repository.getUserFollowers(username, page);
    result.fold(
      (failure) {
        emit(GithubUserFollowersError(failure.failMsg));
      },
      (followers) {
        final _hasReachedMax = followers.length < page;
        _originalFollowers = List.from(followers);
        emit(GithubUserFollowersLoaded(
          followers: followers,
          hasReachedMax: followers.isEmpty ? true : _hasReachedMax,
        ));
      },
    );
  }

  Future<void> loadMoreUserFollowers() async {
    if (state is GithubUserFollowersLoaded) {
      final currentState = state as GithubUserFollowersLoaded;
      if (!currentState.hasReachedMax) {
        // emit(const LoadingMoreFollowers());
        _currentPage++;
        final either =
            await repository.getUserFollowers(_currentQuery, _currentPage);

        either.fold(
          (failure) {
            emit(GithubUserFollowersError(failure.failMsg));
          },
          (moreFollowers) {
            _originalFollowers = [..._originalFollowers, ...moreFollowers]; 
            emit(GithubUserFollowersLoaded(
              followers: [...currentState.followers, ...moreFollowers],
              hasReachedMax: moreFollowers.isEmpty,
            ));

          },
        );
      }
    }
  }
List<Follower> _originalFollowers = [];

void filterUsers(String filter) {
  if (state is GithubUserFollowersLoaded) {
    final currentState = state as GithubUserFollowersLoaded;

    if (filter.isEmpty) {
      emit(GithubUserFollowersLoaded(
        followers: _originalFollowers,
        hasReachedMax: currentState.hasReachedMax
      ));
    } else {
      final filteredUsers = _originalFollowers
          .where((follower) => follower.login!.toLowerCase().contains(filter.toLowerCase()))
          .toList();
      emit(GithubUserFollowersLoaded(
        followers: filteredUsers,
        hasReachedMax: currentState.hasReachedMax
      ));
    }
  }
}

}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:github_api_task/src/data/data_source/local_data_source.dart';
import 'package:github_api_task/src/logic/repositories/github_user_repo.dart';
import 'package:github_api_task/src/models/github_user_model.dart';
import 'package:url_launcher/url_launcher.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit(this.repository) : super(const UserDetailsLoading());
  final GithubUserRepository repository;
  final dbHelper = DatabaseHelper.instance;
  Future<void> getUserInfo(String username) async {
    emit(const UserDetailsLoading());

    final result = await repository.getUserInfo(username);
    result.fold(
      (failure) {
        emit(UserDetailsError(failure.failMsg));
      },
      (githubUser) {
        emit(UserDetailsLoaded(
          user: githubUser,
        ));
      },
    );
  }

  
  toggleFavorite(GithubUser user) async {
    if (await dbHelper.isFavorite(user.userId!)) {
      await dbHelper.deleteFavorite(user.userId!);
    } else {
      await dbHelper.addFavorite(user);
    }
  }

  urlLauncher(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}

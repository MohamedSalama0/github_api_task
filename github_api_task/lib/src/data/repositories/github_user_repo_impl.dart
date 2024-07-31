import 'package:dartz/dartz.dart';
import 'package:github_api_task/src/core/errors/error_handler.dart';
import 'package:github_api_task/src/core/errors/failures.dart';
import 'package:github_api_task/src/data/data_source/remote_data_source.dart';
import 'package:github_api_task/src/logic/repositories/github_user_repo.dart';
import 'package:github_api_task/src/models/follower_model.dart';
import 'package:github_api_task/src/models/github_user_model.dart';

class GithubUserRepositoryImpl implements GithubUserRepository {
  final RemoteDataSource _remoteDataSource;

  GithubUserRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Follower>>> getUserFollowers(
      String username, int page) async {
    try {
      final response = await _remoteDataSource.getUserFollowers(username, page);
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handleError(error));
    }
  }

  @override
  Future<Either<Failure, GithubUser>> getUserInfo(String username)async {
     try {
      final response = await _remoteDataSource.getUserInfo(username);
      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handleError(error));
    }
  }
}

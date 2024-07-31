import 'package:dartz/dartz.dart';
import 'package:github_api_task/src/core/errors/failures.dart';
import 'package:github_api_task/src/models/follower_model.dart';
import 'package:github_api_task/src/models/github_user_model.dart';

abstract class GithubUserRepository{
Future<Either<Failure,List<Follower>>> getUserFollowers(String username, int page);
Future<Either<Failure,GithubUser>> getUserInfo(String username);
}
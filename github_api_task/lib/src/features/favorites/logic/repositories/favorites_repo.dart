import 'package:dartz/dartz.dart';
import 'package:github_api_task/src/core/errors/failures.dart';
import 'package:github_api_task/src/models/github_user_model.dart';

abstract class FavoritesRepository {
  Future<Either<Failure,List<GithubUser>>> getFavorites();
  Future<Either<Failure,int>> addFavorite(GithubUser user);
  Future<Either<Failure,int>> deleteFavorite(int id);
}
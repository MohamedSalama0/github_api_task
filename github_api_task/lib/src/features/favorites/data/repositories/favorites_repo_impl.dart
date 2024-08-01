import 'package:dartz/dartz.dart';
import 'package:github_api_task/src/core/errors/error_handler.dart';
import 'package:github_api_task/src/core/errors/failures.dart';
import 'package:github_api_task/src/features/favorites/data/data%20source/local_data_source.dart';
import 'package:github_api_task/src/features/favorites/logic/repositories/favorites_repo.dart';
import 'package:github_api_task/src/models/github_user_model.dart';

class FavoritesRepositoryImpl extends FavoritesRepository {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  FavoritesRepositoryImpl();
  @override
  Future<Either<Failure, int>> addFavorite(GithubUser user) async {
    try {
      final response = await dbHelper.addFavorite(user);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, int>> deleteFavorite(int id) async {
    try {
      final response = await dbHelper.deleteFavorite(id);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<GithubUser>>> getFavorites() async {
    try {
      final response = await dbHelper.getFavorites();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handleError(e));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:github_api_task/src/features/favorites/logic/repositories/favorites_repo.dart';
import 'package:github_api_task/src/logic/user_details/cubit/user_details_cubit.dart';
import 'package:github_api_task/src/models/github_user_model.dart';

part 'favorites_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  // final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final FavoritesRepository favoritesRepository;

  FavoriteCubit(this.favoritesRepository)
      : super(const FavoritesLoaded(favorites: [])) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final either = await favoritesRepository.getFavorites();
    either.fold(
      (failure) {
        emit(FavoritesError(failMsg: failure.failMsg));
      },
      (favorites) {
        emit(FavoritesLoaded(favorites: favorites));
      },
    );
  }

  Future<void> toggleFavorite(GithubUser user) async {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      final currentFavorites = List<GithubUser>.from(currentState.favorites);
      if (currentFavorites.contains(user)) {
        await favoritesRepository.deleteFavorite(user.id!);
        currentFavorites.remove(user);
      } else {
        await favoritesRepository.addFavorite(user);
        currentFavorites.add(user);
      }
      emit(FavoritesLoaded(favorites: currentFavorites));
      // emit(FavoriteButtonState());
    }
  }

  // Future<bool> isFavorite(int userId) async {
  //   return await favoritesRepository.isFavorite(userId);
  //   // return state.favorites.contains(user);
  // }
}

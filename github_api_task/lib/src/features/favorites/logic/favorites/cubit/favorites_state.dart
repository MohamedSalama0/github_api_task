part of 'favorites_cubit.dart';

sealed class FavoriteState extends Equatable {

  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoritesLoaded extends FavoriteState {
  final List<GithubUser>  favorites;
  const FavoritesLoaded({required this.favorites});

  @override
  List<Object> get props => [favorites];
}
class FavoritesError extends FavoriteState {
  final String failMsg ;
  const FavoritesError({required this.failMsg });

  @override
  List<Object> get props => [failMsg];
}

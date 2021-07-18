part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoritePageInitial extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});
}

class FavoriteLoaded extends FavoriteState {
  final bool statusFavorite;

  FavoriteLoaded({required this.statusFavorite});
}

class FavoritePageError extends FavoriteState {
  final String message;

  FavoritePageError({required this.message});
}

class FavoritePageLoaded extends FavoriteState {
  final List<FavoriteRestaurants> restaurants;

  FavoritePageLoaded({required this.restaurants});
}

class FavoriteNoData extends FavoriteState {
  final String message;

  FavoriteNoData({required this.message});
}


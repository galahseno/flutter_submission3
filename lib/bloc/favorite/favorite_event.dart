part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class FavoriteInitialEvent extends FavoriteEvent {}

class FavoritePageLoadedEvent extends FavoriteEvent {}

class FavoriteLoadedEvent extends FavoriteEvent {
  final String id;

  FavoriteLoadedEvent({required this.id});
}

class AddFavoriteEvent extends FavoriteEvent {
  final Restaurant restaurant;

  AddFavoriteEvent({required this.restaurant});
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final String id;

  RemoveFavoriteEvent({required this.id});
}


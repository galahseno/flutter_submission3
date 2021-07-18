part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchRestaurantError extends SearchState {
  final String message;

  SearchRestaurantError({required this.message});
}

class ListRestaurantSearch extends SearchState {
  final List<Restaurants> listRestaurant;

  ListRestaurantSearch({required this.listRestaurant});
}

class ListRestaurantSearchNotFound extends SearchState {
  final String message;

  ListRestaurantSearchNotFound({required this.message});
}

class LoadingSearch extends SearchState {}

class OpenSearch extends SearchState {}

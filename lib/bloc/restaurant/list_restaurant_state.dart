part of 'list_restaurant_bloc.dart';

@immutable
abstract class ListRestaurantState {}

class ListRestaurantInitial extends ListRestaurantState {}

class ListRestaurantError extends ListRestaurantState {
  final String message;

  ListRestaurantError({required this.message});
}

class ListRestaurantLoaded extends ListRestaurantState {
  final List<Restaurants> listRestaurant;

  ListRestaurantLoaded(
      {required this.listRestaurant});
}

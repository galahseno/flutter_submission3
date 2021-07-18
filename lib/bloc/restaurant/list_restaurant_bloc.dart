import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:submission_1/data/model/Remote/restaurants.dart';
import 'package:submission_1/data/source/repository.dart';

part 'list_restaurant_event.dart';

part 'list_restaurant_state.dart';

class ListRestaurantBloc
    extends Bloc<ListRestaurantEvent, ListRestaurantState> {
  ListRestaurantBloc(this._repository) : super(ListRestaurantInitial());
  final Repository _repository;

  @override
  Stream<ListRestaurantState> mapEventToState(
    ListRestaurantEvent event,
  ) async* {
    if (event is LoadedEvent) {
      try {
        final restaurant = await _repository.getRestaurants();
        yield ListRestaurantLoaded(
            listRestaurant: restaurant.restaurants);
      } catch (e) {
        yield ListRestaurantError(
            message: 'Something wrong, please check internet connection');
      }
    }
  }
}

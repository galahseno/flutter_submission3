import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:submission_1/data/model/remote/restaurants.dart';
import 'package:submission_1/data/source/repository.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._repository) : super(SearchInitial());
  final Repository _repository;

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchSubmitEvent) {
      yield LoadingSearch();
      try {
        final searchRestaurant =
            await _repository.searchRestaurants(event.query);
        if (searchRestaurant.restaurants.length == 0) {
          yield ListRestaurantSearchNotFound(message: 'Restaurant not found');
        } else {
          yield ListRestaurantSearch(
              listRestaurant: searchRestaurant.restaurants);
        }
      } catch (e) {
        yield SearchRestaurantError(
            message: 'Something wrong, please check internet connection');
      }
    }
    if (event is SearchIconEvent) {
      if (event.expand) {
        yield OpenSearch();
      } else {
        yield SearchInitial();
      }
    }
  }
}

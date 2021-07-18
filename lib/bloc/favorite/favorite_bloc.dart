import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:submission_1/data/model/local/favorite_restaurants.dart';
import 'package:submission_1/data/model/remote/detail/restaurant.dart';
import 'package:submission_1/data/source/repository.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc(this._repository) : super(FavoriteInitial());
  final Repository _repository;

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is AddFavoriteEvent) {
      try {
        await _repository.insertFavorite(event.restaurant);
        yield FavoriteLoaded(statusFavorite: true);
      } catch (e) {
        print(e);
        yield FavoriteError(message: 'Something wrong, please try again later');
      }
    }
    if (event is RemoveFavoriteEvent) {
      try {
        await _repository.removeFavorite(event.id);
        yield FavoriteLoaded(statusFavorite: false);
      } catch (e) {
        print(e);
        yield FavoriteError(message: 'Something wrong, please try again later');
      }
    }
    if (event is FavoriteLoadedEvent) {
      var status = await _repository.getFavoriteById(event.id);
      yield FavoriteLoaded(statusFavorite: status.isNotEmpty);
    }
    if (event is FavoritePageLoadedEvent) {
      yield FavoriteInitial();
      try {
        final listFavorite = await _repository.getFavorites();
        if (listFavorite.isEmpty) {
          yield FavoriteNoData(message: 'No Favorite Restaurant');
        } else {
          yield FavoritePageLoaded(restaurants: listFavorite);
        }
      } catch (e) {
        print(e);
        yield FavoritePageError(
            message: 'Something wrong, please try again later');
      }
    }
  }
}

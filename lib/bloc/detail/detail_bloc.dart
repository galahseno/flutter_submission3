import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:submission_1/data/model/remote/detail/detail_restaurant_response.dart';
import 'package:submission_1/data/model/remote/detail/restaurant.dart';
import 'package:submission_1/data/source/repository.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc(this._repository) : super(DetailInitial());
  final Repository _repository;

  @override
  Stream<DetailState> mapEventToState(
    DetailEvent event,
  ) async* {
    if (event is LoadedDetailEvent) {
      try {
        final detailRestaurant =
            await _repository.getDetailRestaurants(event.id);
        final statusFavorite = await _repository.getFavoriteById(event.id);
        yield DetailLoaded(
            detailResponse: detailRestaurant,
            statusFavorite: statusFavorite.isNotEmpty);
      } catch (e) {
        yield DetailError(
            message: 'Something wrong, please check internet connection');
      }
    }
    if (event is DetailInitialEvent) {
      yield DetailInitial();
    }
    if (event is PostDetailReviewEvent) {
      yield DetailInitial();
      try {
        await _repository.postReview(event.id, event.name, event.review);
        final detailRestaurant =
            await _repository.getDetailRestaurants(event.id);
        final statusFavorite = await _repository.getFavoriteById(event.id);
        yield DetailLoaded(
            detailResponse: detailRestaurant,
            statusFavorite: statusFavorite.isNotEmpty);
      } catch (e) {
        yield DetailError(
            message: 'Something wrong, please check internet connection');
      }
    }
  }
}

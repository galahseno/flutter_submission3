import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_1/bloc/favorite/favorite_bloc.dart';
import 'package:submission_1/data/model/local/favorite_restaurants.dart';
import 'package:submission_1/data/model/remote/detail/menus.dart';
import 'package:submission_1/data/model/remote/detail/restaurant.dart';

import '../restaurant/list_restaurant_bloc_test.mocks.dart';

void main() {
  var repository = MockRepository();
  var dummyFavorite = Restaurant(
      id: '1',
      pictureId: '1',
      name: '1',
      address: '1',
      categories: [],
      city: '1',
      customerReviews: [],
      description: '1',
      menus: Menus(drinks: [], foods: []),
      rating: '1');
  var dummyFavoriteRestaurant = FavoriteRestaurants(
      id: '1', pictureId: '1', name: '1', city: '1', rating: '1');

  group('Favorite bloc test', () {
    blocTest(
      'Initial bloc',
      build: () => FavoriteBloc(repository),
      expect: () => [],
    );
    blocTest(
      'Add Favorite Event',
      build: () => FavoriteBloc(repository),
      act: (FavoriteBloc bloc) {
        bloc.add(AddFavoriteEvent(restaurant: dummyFavorite));
      },
      expect: () => [isA<FavoriteLoaded>()],
    );
    blocTest(
      'Remove Favorite Event',
      build: () => FavoriteBloc(repository),
      act: (FavoriteBloc bloc) {
        bloc.add(RemoveFavoriteEvent(id: '1'));
      },
      expect: () => [isA<FavoriteLoaded>()],
    );
    blocTest('Loaded Favorite Status',
        build: () => FavoriteBloc(repository),
        act: (FavoriteBloc bloc) {
          when(repository.getFavoriteById(any))
              .thenAnswer((_) async => Future.value(Map<dynamic, dynamic>()));

          bloc.add(FavoriteLoadedEvent(id: '1'));
        },
        expect: () => [isA<FavoriteLoaded>()],
        verify: (_) {
          verify(repository.getFavoriteById(any));
        });
    blocTest(
      'Loaded Favorite Page Error',
      build: () => FavoriteBloc(repository),
      act: (FavoriteBloc bloc) {
        bloc.add(FavoritePageLoadedEvent());
      },
      expect: () => [isA<FavoriteInitial>(), isA<FavoritePageError>()],
    );
    blocTest('Loaded Favorite Page NoData',
        build: () => FavoriteBloc(repository),
        act: (FavoriteBloc bloc) {
          when(repository.getFavorites())
              .thenAnswer((_) async => Future.value([]));

          bloc.add(FavoritePageLoadedEvent());
        },
        expect: () => [isA<FavoriteInitial>(), isA<FavoriteNoData>()],
        verify: (_) {
          verify(repository.getFavorites());
        });
    blocTest('Loaded Favorite Page',
        build: () => FavoriteBloc(repository),
        act: (FavoriteBloc bloc) {
          when(repository.getFavorites()).thenAnswer((_) async =>
              Future.value([dummyFavoriteRestaurant]));

          bloc.add(FavoritePageLoadedEvent());
        },
        expect: () => [isA<FavoriteInitial>(), isA<FavoritePageLoaded>()],
        verify: (_) {
          verify(repository.getFavorites());
        });
  });
}

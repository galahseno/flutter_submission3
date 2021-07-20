import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_1/bloc/search/search_bloc.dart';
import 'package:submission_1/data/model/remote/restaurant_response.dart';
import 'package:submission_1/data/model/remote/restaurants.dart';

import '../restaurant/list_restaurant_bloc_test.mocks.dart';

void main() {
  var repository = MockRepository();
  var dummySearch =
      Restaurants(id: '1', pictureId: '1', name: '1', city: '1', rating: '1');

  group('Search bloc test', () {
    blocTest(
      'Initial bloc',
      build: () => SearchBloc(repository),
      expect: () => [],
    );
    blocTest(
      'Search icon open event',
      build: () => SearchBloc(repository),
      act: (SearchBloc bloc) {
        bloc.add(SearchIconEvent(expand: true));
      },
      expect: () => [isA<OpenSearch>()],
    );
    blocTest(
      'Search icon initial event',
      build: () => SearchBloc(repository),
      act: (SearchBloc bloc) {
        bloc.add(SearchIconEvent(expand: false));
      },
      expect: () => [isA<SearchInitial>()],
    );
    blocTest(
      'Search submit error',
      build: () => SearchBloc(repository),
      act: (SearchBloc bloc) {
        bloc.add(SearchSubmitEvent(query: 'query'));
      },
      expect: () => [isA<LoadingSearch>(), isA<SearchRestaurantError>()],
    );
    blocTest('Search submit NotFound',
        build: () => SearchBloc(repository),
        act: (SearchBloc bloc) {
          when(repository.searchRestaurants(any)).thenAnswer(
              (_) async => Future.value(RestaurantResponse(restaurants: [])));

          bloc.add(SearchSubmitEvent(query: 'query'));
        },
        expect: () =>
            [isA<LoadingSearch>(), isA<ListRestaurantSearchNotFound>()],
        verify: (_) {
          verify(repository.searchRestaurants(any));
        });
    blocTest('Search submit Found',
        build: () => SearchBloc(repository),
        act: (SearchBloc bloc) {
          when(repository.searchRestaurants(any)).thenAnswer((_) async =>
              Future.value(RestaurantResponse(restaurants: [dummySearch])));

          bloc.add(SearchSubmitEvent(query: 'query'));
        },
        expect: () =>
            [isA<LoadingSearch>(), isA<ListRestaurantSearch>()],
        verify: (_) {
          verify(repository.searchRestaurants(any));
        });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_1/bloc/restaurant/list_restaurant_bloc.dart';
import 'package:submission_1/data/model/remote/restaurant_response.dart';
import 'package:submission_1/data/source/repository.dart';

import 'list_restaurant_bloc_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
  var repository = MockRepository();

  group('List Restaurant Bloc Test ', () {
    blocTest(
      'Initial bloc',
      build: () => ListRestaurantBloc(repository),
      expect: () => [],
    );
    blocTest(
      'Loaded Error Restaurant',
      build: () => ListRestaurantBloc(repository),
      act: (ListRestaurantBloc bloc) {
        bloc.add(LoadedEvent());
      },
      expect: () => [isA<ListRestaurantError>()],
    );
    blocTest('Loaded List Restaurant',
        build: () => ListRestaurantBloc(repository),
        act: (ListRestaurantBloc bloc) {
          when(repository.getRestaurants()).thenAnswer(
              (_) async => Future.value(RestaurantResponse(restaurants: [])));

          bloc.add(LoadedEvent());
        },
        expect: () => [isA<ListRestaurantLoaded>()],
        verify: (_) {
          verify(repository.getRestaurants());
        });
  });
}

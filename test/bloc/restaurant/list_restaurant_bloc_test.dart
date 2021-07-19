import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:submission_1/bloc/restaurant/list_restaurant_bloc.dart';
import 'package:submission_1/data/source/repository.dart';

import '../mock_repository.dart';

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
      'Loaded List Restaurant',
      build: () => ListRestaurantBloc(repository),
      act: (bloc) => (bloc as ListRestaurantBloc).add(LoadedEvent()),
      expect: () =>
      [isA<ListRestaurantLoaded>()],
    );
  });
}

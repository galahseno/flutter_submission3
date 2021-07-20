import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_1/bloc/detail/detail_bloc.dart';
import 'package:submission_1/data/model/remote/detail/detail_restaurant_response.dart';
import 'package:submission_1/data/model/remote/detail/menus.dart';
import 'package:submission_1/data/model/remote/detail/restaurant.dart';

import '../restaurant/list_restaurant_bloc_test.mocks.dart';

void main() {
  var repository = MockRepository();
  var detailDummy = DetailResponse(
      restaurant: Restaurant(
          id: '1',
          pictureId: '1',
          name: '1',
          address: '1',
          categories: [],
          city: '1',
          customerReviews: [],
          description: '1',
          menus: Menus(drinks: [], foods: []),
          rating: '1'));

  group('Detail Bloc Test ', () {
    blocTest(
      'Initial bloc',
      build: () => DetailBloc(repository),
      expect: () => [],
    );
    blocTest(
      'Loading Detail bloc',
      build: () => DetailBloc(repository),
      act: (DetailBloc bloc) => {
        bloc.add(DetailInitialEvent()),
      },
      expect: () => [isA<DetailInitial>()],
    );
    blocTest(
      'Loaded Detail error',
      build: () => DetailBloc(repository),
      act: (DetailBloc bloc) => {
        bloc.add(LoadedDetailEvent(id: '1')),
      },
      expect: () => [isA<DetailError>()],
    );
    blocTest('Loaded Detail Restaurant',
        build: () => DetailBloc(repository),
        act: (DetailBloc bloc) => {
              when(repository.getDetailRestaurant(any))
                  .thenAnswer((_) async => Future.value(detailDummy)),
              when(repository.getFavoriteById(any)).thenAnswer(
                  (_) async => Future.value(Map<dynamic, dynamic>())),
              bloc.add(LoadedDetailEvent(id: '1')),
            },
        expect: () => [isA<DetailLoaded>()],
        verify: (_) {
          verify(repository.getDetailRestaurant(any));
          verify(repository.getFavoriteById(any));
        });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_1/data/model/local/favorite_restaurants.dart';
import 'package:submission_1/data/model/remote/detail/detail_restaurant_response.dart';
import 'package:submission_1/data/model/remote/restaurant_response.dart';
import 'package:submission_1/data/source/local_data_provider.dart';
import 'package:submission_1/data/source/remote_data_provider.dart';
import 'package:submission_1/data/source/repository.dart';
import 'package:submission_1/utils/notification_helper.dart';

import 'repository_test.mocks.dart';
import 'response.dart';

@GenerateMocks([LocalDataProvider, RemoteDataProvider, NotificationHelper])
void main() {
  var remoteDataProvider = MockRemoteDataProvider();
  var localDataProvider = MockLocalDataProvider();
  var notificationHelper = MockNotificationHelper();
  var repository =
      Repository(remoteDataProvider, localDataProvider, notificationHelper);
  var id = 'rqdv5juczeskfw1e867';
  var query = 'kafe';

  group('Repository Test', () {
    test('Get List Restaurant', () async {
      when(remoteDataProvider.getRestaurants()).thenAnswer(
        (_) => Future.value(
          RestaurantResponse.fromJson(restaurantsResponse),
        ),
      );
      var result = await repository.getRestaurants();
      verify(remoteDataProvider.getRestaurants());

      expect(result.restaurants.length, 20);
    });

    test('Search Restaurant', () async {
      when(remoteDataProvider.searchRestaurants(query)).thenAnswer(
        (_) => Future.value(
          RestaurantResponse.fromJson(searchResponse),
        ),
      );
      RestaurantResponse result =
          await repository.searchRestaurants(query);
      verify(remoteDataProvider.searchRestaurants(query));

      expect(result.restaurants.length, 4);
    });

    test('Get Detail Restaurant', () async {
      when(remoteDataProvider.getDetailRestaurant(id)).thenAnswer(
            (_) => Future.value(
          DetailResponse.fromJson(detailResponse),
        ),
      );
      DetailResponse result = await repository.getDetailRestaurant(id);
      verify(remoteDataProvider.getDetailRestaurant(id));

      expect(result.restaurant.id, id);
      expect(result.restaurant.name, 'Melting Pot');
      expect(result.restaurant.city, 'Medan');
      expect(result.restaurant.address, 'Jln. Pandeglang no 19');
    });

    test('Get Favorite Restaurant', () async {
      when(localDataProvider.getFavorites()).thenAnswer(
            (_) => Future.value(
          favoriteResponse.map((e) => FavoriteRestaurants.fromMap(e)).toList(),
        ),
      );
      List<FavoriteRestaurants> result = await repository.getFavorites();
      verify(localDataProvider.getFavorites());

      expect(result.length, 4);
      expect(result[0].name, 'Kafe Kita');
      expect(result[1].name, 'Kafein');
      expect(result[2].name, 'Kafe Cemara');
      expect(result[3].name, 'Manis Asam Kafe');
    });
  });
}

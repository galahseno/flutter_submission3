import 'package:submission_1/data/model/remote/restaurant_response.dart';
import 'package:submission_1/data/model/local/favorite_restaurants.dart';
import 'package:submission_1/data/model/remote/detail/customer_reviews.dart';
import 'package:submission_1/data/model/remote/detail/detail_restaurant_response.dart';
import 'package:submission_1/data/model/remote/detail/restaurant.dart';
import 'package:submission_1/data/source/local_data_provider.dart';
import 'package:submission_1/data/source/remote_data_provider.dart';
import 'package:submission_1/utils/notification_helper.dart';

class Repository {
  static final Repository _repository = Repository._internal();

  factory Repository() {
    return _repository;
  }

  Repository._internal();

  final _remoteDataProvider = RemoteDataProvider();
  final _localDataProvider = LocalDataProvider();
  final _notificationHelper = NotificationHelper();

  Future<RestaurantResponse> getRestaurants() async {
    return await _remoteDataProvider.getRestaurants();
  }

  Future<RestaurantResponse> searchRestaurants(String query) async {
    return await _remoteDataProvider.searchRestaurants(query);
  }

  Future<DetailResponse> getDetailRestaurants(String id) async {
    return await _remoteDataProvider.getDetailRestaurant(id);
  }

  Future postReview(String id, String name, String review) async {
    var postReview = CustomerReviews(id: id, name: name, review: review);
    return await _remoteDataProvider.postReview(postReview, id);
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    var favoriteRestaurant = FavoriteRestaurants(
        id: restaurant.id,
        name: restaurant.name,
        pictureId: restaurant.pictureId,
        city: restaurant.city,
        rating: restaurant.rating);
    await _localDataProvider.insertFavorite(favoriteRestaurant);
  }

  Future<List<FavoriteRestaurants>> getFavorites() async {
    return _localDataProvider.getFavorites();
  }

  Future<Map> getFavoriteById(String id) async {
    return await _localDataProvider.getFavoriteById(id);
  }

  Future<void> removeFavorite(String id) async {
    await _localDataProvider.removeFavorite(id);
  }

  Future<bool> get isDailyReminder async {
    return _localDataProvider.isDailyReminder;
  }

  void setDailyReminder(bool value) async {
    _localDataProvider.setDailyReminder(value);
  }

  void configureSelectNotificationSubject(String route, int index) {
    _localDataProvider.setIndexNotification(index);
    _notificationHelper.configureSelectNotificationSubject(route, index);
  }
}

import 'package:submission_1/data/db/database_helper.dart';
import 'package:submission_1/data/model/local/favorite_restaurants.dart';

class LocalDataProvider {
  final _databaseHelper = DatabaseHelper();

  Future<void> insertFavorite(FavoriteRestaurants restaurant) async {
    _databaseHelper.insertFavorite(restaurant);
  }

  Future<List<FavoriteRestaurants>> getFavorites() async {
    return _databaseHelper.getFavorites();
  }

  Future<Map> getFavoriteById(String id) async {
    return _databaseHelper.getFavoriteById(id);
  }

  Future<void> removeFavorite(String id) async {
    _databaseHelper.removeFavorite(id);
  }
}

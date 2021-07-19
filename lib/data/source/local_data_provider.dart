import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_1/data/local/database_helper.dart';
import 'package:submission_1/data/local/preferences_helper.dart';
import 'package:submission_1/data/model/local/favorite_restaurants.dart';

class LocalDataProvider {
  final _databaseHelper = DatabaseHelper();
  final _preferencesHelper = PreferencesHelper(
    sharedPreferences: SharedPreferences.getInstance(),
  );

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

  Future<bool> get isDailyReminder async {
    return _preferencesHelper.isDailyReminder;
  }

  void setDailyReminder(bool value) async {
    _preferencesHelper.setDailyReminder(value);
  }

  void setIndexNotification(int value) async {
    _preferencesHelper.setIndexNotification(value);
  }
}

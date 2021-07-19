import 'package:shared_preferences/shared_preferences.dart';

const NOTIFICATION_INDEX_KEY = 'NOTIFICATION_INDEX_KEY';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const DAILY_REMINDER = 'DAILY_REMINDER';

  Future<bool> get isDailyReminder async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_REMINDER) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_REMINDER, value);
  }

  void setIndexNotification(int value) async {
    final prefs = await sharedPreferences;
    prefs.setInt(NOTIFICATION_INDEX_KEY, value);
  }
}

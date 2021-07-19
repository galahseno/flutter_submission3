import 'dart:isolate';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_1/data/api/api_service.dart';
import 'package:submission_1/main.dart';
import 'package:submission_1/utils/notification_helper.dart';
import 'package:submission_1/data/local/preferences_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  static final BackgroundService _backgroundService =
      BackgroundService._internal();

  factory BackgroundService() {
    return _backgroundService;
  }

  BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();
    var response = await ApiService().getRestaurants();
    final prefs = await SharedPreferences.getInstance();
    var index = prefs.getInt(NOTIFICATION_INDEX_KEY);
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, response, index!);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}

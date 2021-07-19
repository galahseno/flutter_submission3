import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:submission_1/common/navigation.dart';
import 'package:submission_1/data/model/remote/restaurant_response.dart';

final selectNotificationSubject = BehaviorSubject<String>();
final notificationId = 1;

class NotificationHelper {
  static final NotificationHelper _notificationHelper =
      NotificationHelper._internal();

  factory NotificationHelper() {
    return _notificationHelper;
  }

  NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResponse restaurantResponse,
      int index) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "restaurants channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Recommended Restaurant for you!</b>";
    var titleRestaurant = restaurantResponse.restaurants[index].name;

    await flutterLocalNotificationsPlugin.show(
        notificationId, titleNotification, titleRestaurant, platformChannelSpecifics,
        payload: json.encode(restaurantResponse.toJson()));
  }

  void configureSelectNotificationSubject(String route, int index) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantResponse.fromJson(json.decode(payload));
        var article = data.restaurants[index].id;
        Navigation.intentWithData(route, article);
      },
    );
  }
}

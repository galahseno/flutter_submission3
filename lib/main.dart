import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:submission_1/bloc/detail/detail_bloc.dart';
import 'package:submission_1/bloc/favorite/favorite_bloc.dart';
import 'package:submission_1/bloc/restaurant/list_restaurant_bloc.dart';
import 'package:submission_1/bloc/search/search_bloc.dart';
import 'package:submission_1/bloc/setting/setting_bloc.dart';
import 'package:submission_1/common/navigation.dart';
import 'package:submission_1/common/styles.dart';
import 'package:submission_1/data/source/repository.dart';
import 'package:submission_1/ui/detail_page.dart';
import 'package:submission_1/ui/favorite_page.dart';
import 'package:submission_1/ui/home_page.dart';
import 'package:submission_1/ui/search_page.dart';
import 'package:submission_1/ui/setting_page.dart';
import 'package:submission_1/utils/background_service.dart';
import 'package:submission_1/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListRestaurantBloc>(
          create: (_) => ListRestaurantBloc(
            Repository(),
          ),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => SearchBloc(
            Repository(),
          ),
        ),
        BlocProvider<DetailBloc>(
          create: (_) => DetailBloc(
            Repository(),
          ),
        ),
        BlocProvider<FavoriteBloc>(
          create: (_) => FavoriteBloc(
            Repository(),
          ),
        ),
        BlocProvider<SettingBloc>(
          create: (_) => SettingBloc(
            Repository(),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Restaurant',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 0,
          ),
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          DetailPage.routeName: (context) => DetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
          SearchPage.routeName: (context) => SearchPage(),
          FavoritePage.routeName: (context) => FavoritePage(),
          SettingPage.routeName: (context) => SettingPage(),
        },
      ),
    );
  }
}

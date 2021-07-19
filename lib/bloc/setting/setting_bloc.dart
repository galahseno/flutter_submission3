import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:submission_1/data/source/repository.dart';
import 'package:submission_1/utils/background_service.dart';
import 'package:submission_1/utils/date_time_helper.dart';
import 'package:submission_1/utils/notification_helper.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc(this._repository) : super(SettingInitial());
  final Repository _repository;

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    if (event is GetDailyReminder) {
      try {
        final isDailyReminder = await _repository.isDailyReminder;
        yield SettingLoaded(value: isDailyReminder);
      } catch (e) {
        yield SettingError(message: 'Something Wrong, try again later');
      }
    }
    if (event is SetDailyReminder) {
      _repository.setDailyReminder(event.value);
      final isDailyReminder = await _repository.isDailyReminder;
      yield SettingLoaded(value: isDailyReminder);
      if (event.value) {
        _repository.configureSelectNotificationSubject(event.route, event.index);
        await AndroidAlarmManager.periodic(
          Duration(hours: 24),
          notificationId,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
        );
      } else {
        await AndroidAlarmManager.cancel(notificationId);
      }
    }
  }
}

part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class GetDailyReminder extends SettingEvent {}

class SetDailyReminder extends SettingEvent {
  final bool value;
  final String route;
  final int index;

  SetDailyReminder(
      {required this.value, required this.route, required this.index});
}

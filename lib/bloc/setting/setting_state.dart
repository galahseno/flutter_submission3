part of 'setting_bloc.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingLoaded extends SettingState {
  final bool value;

  SettingLoaded({required this.value});
}

class SettingError extends SettingState {
  final String message;

  SettingError({required this.message});
}

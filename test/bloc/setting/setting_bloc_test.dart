import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_1/bloc/setting/setting_bloc.dart';

import '../restaurant/list_restaurant_bloc_test.mocks.dart';

void main() {
  var repository = MockRepository();

  group('Setting bloc test', () {
    blocTest(
      'Initial bloc',
      build: () => SettingBloc(repository),
      expect: () => [],
    );
    blocTest(
      'Get reminder error',
      build: () => SettingBloc(repository),
      act: (SettingBloc bloc) {
        bloc.add(GetDailyReminder());
      },
      expect: () => [isA<SettingError>()],
    );
    blocTest(
      'Get reminder',
      build: () => SettingBloc(repository),
      act: (SettingBloc bloc) {
        when(repository.isDailyReminder).thenAnswer((_) => Future.value(false));

        bloc.add(GetDailyReminder());
      },
      expect: () => [isA<SettingLoaded>()],
      verify: (_) {
        verify(repository.isDailyReminder);
      }
    );
    blocTest(
      'Set reminder',
      build: () => SettingBloc(repository),
      act: (SettingBloc bloc) {
        when(repository.isDailyReminder).thenAnswer((_) => Future.value(true));

        bloc.add(SetDailyReminder(index: 0, value: true, route: ''));
      },
      expect: () => [isA<SettingLoaded>()],
      verify: (_) {
        verify(repository.isDailyReminder);
      }
    );
  });
}

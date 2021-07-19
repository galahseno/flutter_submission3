import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_1/bloc/setting/setting_bloc.dart';
import 'package:submission_1/common/navigation.dart';
import 'package:submission_1/common/styles.dart';
import 'package:submission_1/ui/detail_page.dart';
import 'package:submission_1/ui/widgets/error_widget.dart';

class SettingPage extends StatefulWidget {
  static const routeName = 'setting_page';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          leading: GestureDetector(
            onTap: () {
              Navigation.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          backgroundColor: primaryColor,
          title: Container(
            margin: EdgeInsets.only(right: 45),
            child: Center(
              child: Text('Setting'),
            ),
          ),
        ),
        body: BlocBuilder<SettingBloc, SettingState>(
          builder: (_, state) {
            if (state is SettingLoaded) {
              return Material(
                child: ListTile(
                  title: Text('Daily Reminder'),
                  trailing: Switch.adaptive(
                    value: state.value,
                    onChanged: (value) {
                      int randomIndex = Random().nextInt(20);
                      context.read<SettingBloc>().add(
                            SetDailyReminder(
                              value: value,
                              route: DetailPage.routeName,
                              index: randomIndex,
                            ),
                          );
                      _setDailyReminder(value);
                    },
                  ),
                ),
              );
            } else {
              return buildErrorWidget(
                  (state as SettingError).message, Icons.error);
            }
          },
        ),
      ),
    );
  }

  void _setDailyReminder(bool favorite) {
    if (favorite) {
      final snackBar = SnackBar(
        content: Text('Daily Reminder Start'),
        backgroundColor: Colors.green[300],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Daily Reminder Stop'),
        backgroundColor: Colors.green[300],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

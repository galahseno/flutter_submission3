import 'package:flutter/material.dart';
import 'package:submission_1/common/styles.dart';

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
              Navigator.pop(context);
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
              child: Text('Settings'),
            ),
          ),
        ),
        body: Center(
          child: Text('SettingPage'),
        ),
      ),
    );
  }
}

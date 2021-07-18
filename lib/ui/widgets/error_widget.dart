import 'package:flutter/material.dart';
import 'package:submission_1/common/styles.dart';

Widget buildErrorWidget(String message) {
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 75,
            color: secondaryColor,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            message,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green[800]),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}

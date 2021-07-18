import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:submission_1/data/model/remote/detail/drinks.dart';

Widget buildDrinksItems(BuildContext context, Drinks drinks) {
  return Container(
    margin: EdgeInsets.only(right: 5),
    child: Column(
      children: [
        Lottie.asset(
          'assets/drinks.json',
          repeat: true,
          reverse: true,
          animate: true,
          width: 125,
          height: 100,
        ),
        Text(drinks.name),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:submission_1/common/styles.dart';

class IconBox extends StatelessWidget {
  final Widget child;
  final double width, height;

  IconBox({
    required this.child,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.green.withAlpha(200), blurRadius: 7)
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Center(
        child: child,
      ),
    );
  }
}

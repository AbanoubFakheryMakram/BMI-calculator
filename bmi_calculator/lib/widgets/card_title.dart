import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  CardTitle({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: title, style: _titleStyle, children: [
        TextSpan(text: subtitle ?? "", style: _subtitleStyle),
      ]),
    );
  }

  TextStyle _titleStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(14, 24, 35, 1.0),
  );
  TextStyle _subtitleStyle = TextStyle(
    fontSize: 8.0,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(78, 102, 114, 1.0),
  );
}

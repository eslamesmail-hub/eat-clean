import 'package:falafel/helper/size_config.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double height;
  final TextDecoration textDecoration;
  final TextOverflow textOverflow;
  final Color color;
  final int maxLines;
  final double letterSpacing;

  AppText(
      {this.text = '',
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.height = 1.2,
      this.textDecoration,
      this.textOverflow,
      this.color,
      this.maxLines,
      this.letterSpacing}) {}

  AppText.heading(
      {this.text = '',
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.height = 1.2,
      this.textDecoration,
      this.textOverflow,
      this.color,
      this.maxLines,
      this.letterSpacing}) {}

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: getSizeText(fontSize),
          fontWeight: fontWeight,
          decoration: textDecoration,
          height: height,
         // fontFamily: 'Cairo',
          color: color,
          letterSpacing: letterSpacing),
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}

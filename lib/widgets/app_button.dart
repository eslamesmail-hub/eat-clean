import 'package:falafel/helper/size_config.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color disabledColor;
  final Color textColor;
  final Function onPressed;
  final double minWidth;
  final double minvertical;
  final double verticalPadding;
  final double horizontalPadding;
  final BorderRadius borderRadius;
  final double fontSize;

  AppButton(
      {this.text = '',
      this.color,
      this.minvertical,
      this.textColor,
      this.onPressed,
      this.minWidth,
      this.verticalPadding = 5,
      this.horizontalPadding = 24,
      this.disabledColor,
      this.borderRadius,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(10)),
      color: color ?? AppColors.primary,
      disabledColor: disabledColor,
      child: AppText(
        text: text,
        color: textColor ?? Colors.white,
        fontSize: fontSize == null ? getSizeText(3.7) : fontSize,
      ),
      onPressed: onPressed,
      minWidth: minWidth,
      padding: EdgeInsets.symmetric(
          vertical: minvertical == null ? 15 : minvertical, horizontal: 20),
    );
  }
}

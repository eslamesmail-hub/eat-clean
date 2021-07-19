import 'package:falafel/widgets/app_colors.dart';
import 'package:flutter/material.dart';

import '../helper/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key key, this.text, this.press, this.colors, this.textcolor})
      : super(key: key);
  final String text;
  final Function press;
  final Color colors;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 10,
                color: AppColors.grey.withOpacity(0.5))
          ]),
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: textcolor,
          ),
        ),
      ),
    );
  }
}

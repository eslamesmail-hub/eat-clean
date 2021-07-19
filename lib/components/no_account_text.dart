import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ConfirmIdentity extends StatelessWidget {
  const ConfirmIdentity({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NewWidget(
          size: size,
          text: 'Face ID',
          img: 'assets/images/1900474-200.png',
          press: () {},
        ),
        SizedBox(
          width: 20,
        ),
        NewWidget(
          size: size,
          text: 'Finger Print',
          img: 'assets/images/fingerprint_PNG32.png',
          press: () {},
        )
      ],
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget(
      {Key key,
      @required this.size,
      @required this.text,
      @required this.press,
      @required this.img})
      : super(key: key);

  final Size size;
  final String text;
  final press;
  final String img;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: press,
      padding: EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 20,
              color: AppColors.grey.withOpacity(0.250))
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffF1F8FF),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Image.asset(
                    img,
                    height: 55,
                    width: 60,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AppText(
                    text: text,
                    fontSize: size.height * 0.013,
                    color: Colors.black45,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

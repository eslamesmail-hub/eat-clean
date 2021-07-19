import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Hero(
                tag: 'img',
                child: Image.asset(
                  'assets/images/chicken-steak-with-lemon-tomato-chili-carrot-white-plate.png',
                  fit: BoxFit.cover,
                  width: size.width * 1,
                ),
              ),
            ),
            FadeInUp(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.260,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25))),
                      width: size.width * 1,
                      child: BodyOfLogin(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

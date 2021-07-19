import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:falafel/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: LoginScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
   // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.4,
              alwaysIncludeSemantics: true,
              child: Image.asset(
                'assets/images/2548748.png',
              ),
            ),
          ),
          FadeInUp(
              child: Center(child: Image.asset('assets/images/Image 1.png')))
        ],
      ),
    );
  }
}

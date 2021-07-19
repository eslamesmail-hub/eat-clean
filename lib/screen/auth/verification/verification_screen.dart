import 'dart:async';

import 'package:falafel/helper/size_config.dart';
import 'package:falafel/screen/home/home_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.reset();
    });
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'تاكيد رقم الهاتف',
                      style: TextStyle(
                          fontSize: getSizeText(4.6),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary),
                    ),
                  ),
                ),
                VerificationCode(
                  itemSize: getSizeText(8),
                  textStyle: TextStyle(fontSize: 20.0, color: Colors.black54),
                  keyboardType: TextInputType.number,
                  // in case underline color is null it will use primaryColor: Colors.red from Theme
                  underlineColor: AppColors.primary,
                  fillColor: AppColors.primary,
                  length: 4,
                  // clearAll is NOT required, you can delete it
                  // takes any widget, so you can implement your design
                  clearAll: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'clear all',
                      style: TextStyle(
                          fontSize: getSizeText(3.7),
                          decoration: TextDecoration.underline,
                          color: AppColors.primary),
                    ),
                  ),
                  onCompleted: (String value) {
                    setState(() {
                      //  _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      // _onEditing = value;
                    });
                    // if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                RoundedLoadingButton(
                  width: MediaQuery.of(context).size.width * 1,
                  height: getProportionateScreenHeight(47),
                  borderRadius: 10,
                  color: AppColors.primary,
                  child: Text('دخول',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  controller: _btnController,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                      _doSomething();
                    } else {
                      _btnController.reset();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

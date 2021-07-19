import 'dart:async';

import 'package:falafel/apis/auth_api.dart';
import 'package:falafel/helper/size_config.dart';
import 'package:falafel/screen/auth/sginup/sginup_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:falafel/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class BodyOfLogin extends StatefulWidget {
  @override
  _BodyOfLoginState createState() => _BodyOfLoginState();
}

class _BodyOfLoginState extends State<BodyOfLogin> {
  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.reset();
    });
  }

  bool _isHidden = false;

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {},
                    child: AppText(
                      text: 'تسجيل دخول',
                      color: Colors.green,
                      fontSize: 3.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(100),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignUpScreen()));
                    },
                    child: AppText(
                      text: 'حساب جديد',
                      color: Colors.black54,
                      fontSize: 3.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              SocialLogin(
                onTap: () {},
                icon: 'assets/icons/facebook.svg',
                title: 'التسجيل ب استخدام فيس بوك',
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              SocialLogin(
                onTap: () {},
                icon: 'assets/icons/google.svg',
                title: 'التسجيل ب استخدام جوجل',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: getProportionateScreenHeight(1.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(
                        text: 'Or',
                        color: Colors.black,
                        fontSize: 3.5,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: getProportionateScreenHeight(1.5),
                      ),
                    ),
                  ],
                ),
              ),
              UserData(
                  hint: '',
                  obSecureText: false,
                  icon: IconButton(
                    icon: Icon(Icons.email_sharp,color: AppColors.primary,), onPressed: () {  },
                  ),
                  controller: _email,
                  label: 'البريد الالكتروني',
                  validator: qValidator([
                    IsEmail(),
                    MinLength(4, ''),
                  ])),
              UserData(
                  icon: IconButton(
                      icon: _isHidden == false ?Icon(Icons.remove_red_eye):Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      }),
                  obSecureText: _isHidden,
                  hint: '',
                  label: 'كلمة المرور',
                  controller: _password,
                  validator: qValidator([
                    MinLength(4),
                    MaxLength(15, ""),
                  ])),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: AppText(
                      text: 'هل نسيت كلمة المرور ؟',
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 3.3,
                    ),
                  )
                ],
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
                    Auth().UserLogin(_email.text, _password.text, context);
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
    );
  }
}

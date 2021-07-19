import 'dart:async';

import 'package:falafel/apis/auth_api.dart';
import 'package:falafel/helper/size_config.dart';
import 'package:falafel/screen/auth/login/login_screen.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/app_text.dart';
import 'package:falafel/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class BodyOfSginUp extends StatefulWidget {
  @override
  _BodyOfSginUpState createState() => _BodyOfSginUpState();
}

class _BodyOfSginUpState extends State<BodyOfSginUp> {
  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.reset();
    });
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _passwordConfirmation = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    child: AppText(
                      text: 'تسجيل دخول',
                      color: Colors.black54,
                      fontSize: 3.7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(100),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {  },
                    child: AppText(
                      text: 'حساب جديد',
                      color: Colors.green,
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
                  controller: _name,
                  label: 'الاسم',
                  obSecureText: false,
                  validator: qValidator([
                    MinLength(4),
                    MaxLength(11,
                        "optionally you can decide which message to display if the validation fails"),
                  ])),
              UserData(
                  controller: _email,
                  hint: '',
                  label: 'البريد الالكتروني',
                  obSecureText: false,
                  icon: IconButton(
                    icon: Icon(Icons.email_sharp,color: AppColors.primary,), onPressed: () {  },
                  ),
                  validator: qValidator([
                    IsEmail(
                      'الايميل غير صحيح'
                    ),
                    MinLength(4, ''),
                  ])),
              UserData(
                  controller: _phoneNumber,
                  hint: '',
                  label: 'رقم الهاتف',
                  obSecureText: false,
                  icon: IconButton(
                    icon: Icon(Icons.phone_android,color: AppColors.primary,), onPressed: () {  },
                  ),
                  validator: qValidator([
                    MinLength(4,'رقم الهاتف غير صحيح'),
                    MaxLength(11, "رقم الهاتف غير صحيح"),
                  ])),
              UserData(
                  controller: _password,
                  hint: '',
                  obSecureText: false,
                  label: 'كلمة المرور',
                  icon: IconButton(
                    icon: Icon(Icons.lock,color: AppColors.primary,), onPressed: () {  },
                  ),
                  validator: qValidator([
                    MinLength(4),
                    MaxLength(15, ""),
                  ])),
              UserData(
                  controller:  _passwordConfirmation,
                  hint: '',
                  obSecureText: false,
                  label: 'تأكيد كلمه المرور',
                  icon: IconButton(
                    icon: Icon(Icons.lock,color: AppColors.primary,), onPressed: () {  },
                  ),
                  validator: (String value) {
              if (value.isEmpty) {
              return 'من فضلك ادخل كلمه السر متطابقه';
              }

              if (value != _password.text) {
              return "كلمه السر غير متطابقه";
              }

              return null;
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
                  if (_formKey.currentState.validate() && _password.text == _passwordConfirmation.text) {
                    _formKey.currentState.save();
                   // formState.save();
                    Auth().UserRegister(_name.text, _email.text, _password.text,
                        _phoneNumber.text, context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => VerificationScreen()));
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

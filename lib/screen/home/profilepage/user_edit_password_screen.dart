import 'dart:async';
import 'package:falafel/helper/size_config.dart';
import 'package:falafel/provider/user_information_provider/user_information.dart';
import 'package:falafel/widgets/app_colors.dart';
import 'package:falafel/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UserEditPasswordScreen extends StatefulWidget {
  static const String id = 'ForgetPassword';

  @override
  _UserEditPasswordScreenState createState() => _UserEditPasswordScreenState();
}

class _UserEditPasswordScreenState extends State<UserEditPasswordScreen> {
  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.reset();
      _btnController.stop();
    });
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController password = new TextEditingController();
  TextEditingController passwordConfirmation = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var getUserData =
        Provider.of<UserInformationProvider>(context, listen: false);
    getUserData.callAPIForUserInformation();
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              IconButton(
                alignment: Alignment.topLeft,
                  icon: Icon(Icons.arrow_forward_ios_outlined,color: AppColors.primary,), onPressed: (){
                Navigator.of(context).pop();
              }),
              SizedBox(
                height: height / 20,
              ),
              Container(
                  height: height / 5,
                  child: Image.asset(
                    'assets/images/Image 1.png',
                    fit: BoxFit.contain,
                  )),
              SizedBox(
                height: height * .03,
              ),
              Text(
                'هل نسيت كلمة السر؟',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.yellow),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * .05,
              ),
              UserData(
                label: 'كلمه المرور',
                controller: password,
              ),
              SizedBox(
                height: height * .01,
              ),
              UserData(
                label: 'تأكيد كملة المرور',
                controller: passwordConfirmation,
              ),
              SizedBox(
                height: height * .03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundedLoadingButton(
                  width: MediaQuery.of(context).size.width * 1,
                  height: getProportionateScreenHeight(47),
                  borderRadius: 10,
                  color: AppColors.primary,
                  child: Text('تغير',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  controller: _btnController,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Provider.of<UserInformationProvider>(context,
                              listen: false)
                          .userChangePassword(password.text,
                              passwordConfirmation.text, context);

                    } else {
                      _btnController.reset();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

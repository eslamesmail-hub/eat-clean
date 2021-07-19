import 'dart:convert';
import 'package:falafel/screen/auth/login/login_screen.dart';
import 'package:falafel/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'api_manager.dart';
import 'constant.dart';

class Auth {
  ///this method for Login
  Future<Null> UserLogin(String email, password, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var body = {"email": email, "password": password};
    var response = await CallAPI().post(
      HOST + LOGIN,
      body,
    );
    var data = json.decode(response.body);
    print(data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      String token = data['token'];
      sharedPreferences.setString('token', token);
      print(token);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Get.snackbar(data['message'].toString(), data['message']);
    }
  }

  Future<Null> UserRegister(String name, email, password, mobile,
      BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var body = {
      "name": name,
      "email": email,
      "password": password,
      "mobile": mobile,
      "password confirmation": password
    };
    var response = await CallAPI().post(
      HOST + REGISTER,
      body,
    );
    var data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      String token = data['token'];
      sharedPreferences.setString('token', token);
      print(token);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Get.snackbar(data['error_message'].toString(), data['error_message']);
    }
  }

  ///this method for ForgetPassword
  Future<Null> UserForgetPassword(String email,
      BuildContext context,) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var body = {
      "email": email,
    };
    var response = await CallAPI().post(
      FORGOTPASS,
      body,
    );
    var data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200) {
      String token = data['data']['api_token'];
      sharedPreferences.setString('token', token);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Get.snackbar(data['status'].toString(), data['message']);
    }
  }

  Future<Null> UpdateProfile(String name,
      email,
      mobile,
      password,
      passwordConfirmation,
      BuildContext context,) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    var body = {
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "branch_id": 1.toString(),
      'role': 1.toString()
    };
    var header = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var response = await CallAPI().put(
      LOGIN,
      header,
      body,
    );
    if (response.statusCode == 200) {} else {
      //Get.snackbar(data['status'].toString(), data['message']);
    }
  }

  Future<Null> UserLogOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    var response = await CallAPI().post('https://falafel.matsuda.website/api/logout',{},

        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },);
        var data = json.decode(response.body);
    print(data);
    print(response.statusCode);
    sharedPreferences.clear();
    if (response.statusCode == 200) {
      print(token);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Get.snackbar(data['message'].toString(), data['message']);
    }
  }
}

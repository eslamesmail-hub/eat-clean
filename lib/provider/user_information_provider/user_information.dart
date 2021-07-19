import 'dart:convert';
import 'package:falafel/model/user_information_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserInformationProvider with ChangeNotifier {
  UserInformation user;

  get userInformationData => user;

  Future<Null> callAPIForUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http.get(
      Uri.parse('https://falafel.matsuda.website/api/user'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      print('Error Calling User Information API');
    } else {
      user = UserInformation.fromJson(json.decode(response.body));
      notifyListeners();
      print('Successfully API For User Information');
    }
  }

  userEditInformation(
      String name, String mobile, String address, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http
        .post(Uri.parse('https://falafel.matsuda.website/api/user_edit'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'name': name,
      'mobile': mobile,
      'address': address,
    });
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
     print('Error Editing User Information');
    } else {
      callAPIForUserInformation();
     Navigator.of(context).pop();
     notifyListeners();
    }
  }

  userChangePassword(String password, String password_confirmation,BuildContext context
     ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http
        .post(Uri.parse('https://falafel.matsuda.website/api/user_password'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'password': password,
      'password_confirmation': password_confirmation,
    });
    int statusCode = response.statusCode;
    var list = json.decode(response.body);

    print(list);
    print(response.statusCode);
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      Get.snackbar(list['message'], list['message']);
    } else {
      Navigator.of(context).pop();
      print(list);
      Get.snackbar(list['message'], list['message']);
    }
  }
}

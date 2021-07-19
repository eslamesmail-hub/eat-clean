import 'dart:convert';

import 'package:falafel/model/rate_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RateProvider with ChangeNotifier {
  Rate list;
  var counter = 0;

  get getRateData => list;

  Future<Null> addRate(String id, String rate, String content ,BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http
        .post(Uri.parse('https://falafel.matsuda.website/api/add_comment'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'id': id,
      'rate': rate,
      'content': content,
    });
    int statusCode = response.statusCode;
    var list = json.decode(response.body);
    print(list);
    print(response.statusCode);
    if (statusCode == 200) {
      // Get.snackbar(list['message'], list['message']);
      Get.back();
       Get.snackbar(list['message'], list['message']);
     notifyListeners();
    } else {
      print(list);
      Get.snackbar(list['message'], list['message']);
      print("Error Can\'t Add Rate");
    }
  }

  Future<Null> callAPIForAllRates(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http.get(
      Uri.parse('https://falafel.matsuda.website/api/get_comments/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      // Map<String, dynamic> mapResponse = json.decode(response.body);
      print('Error Calling All Rates API');
    } else {
      list = Rate.fromJson(json.decode(response.body));
      counter = list.rate.length;
      print(counter);
      print("Success Calling All Rates API");
      notifyListeners();
    }
  }
}

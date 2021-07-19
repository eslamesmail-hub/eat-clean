import 'package:falafel/model/get_one_order_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GetOneOrderProvider with ChangeNotifier {
  OneOrder list;
  get getOneOrderData => list;

  Future<Null> callAPIForGetOneOrderData(String input) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http.get(
      Uri.parse('https://falafel.matsuda.website/api/get_order/$input'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    );
    int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 400 || json == null) {
      print('Error getting one order details');
    } else {
      list = OneOrder.fromJson(json.decode(response.body));
      notifyListeners();
      print('Success getting one order details');
      print(list.message);

    }
  }
}

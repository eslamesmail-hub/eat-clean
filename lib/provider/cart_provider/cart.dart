import 'package:falafel/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  Cart list;
  var counter = 0;

  get getCartData => list;

  Future<Null> addToCart(String id, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http
        .post(Uri.parse('https://falafel.matsuda.website/api/add_to_cart'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'id': id,
    });
    int statusCode = response.statusCode;
    var list = json.decode(response.body);
    print(list);
    print(response.statusCode);
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      Get.snackbar(list['message'], list['message']);
    } else {
      print(list);
      Get.snackbar(list['message'], list['message']);
    }
  }

  Future<void> cartProperties(String id, String url) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    var response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "id": id,
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      callAPIForCart();
      print(data);
    } else {
      print(response.body);
      print(response.statusCode);
      notifyListeners();
    }
  }

  Future<Null> callAPIForCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http.get(
      Uri.parse('https://falafel.matsuda.website/api/get_cart'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      //Map<String, dynamic> mapResponse = json.decode(response.body);
      print('Error calling Cart API');
    } else {
      list = Cart.fromJson(json.decode(response.body));
      counter = list.data.length;
      print(counter);
      notifyListeners();
    }
  }
}

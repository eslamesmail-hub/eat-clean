import 'dart:convert';

import 'package:falafel/model/get_one_product_model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetOneProductProvider with ChangeNotifier {
  GetOneProduct list;
  int counter;

  get getOneProductData => list;

  Future<Null> callAPIForGetOneProductData(String input) async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://falafel.matsuda.website/api/product/$input'),
      );
      int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 400 || json == null) {
      } else {
        list = GetOneProduct.fromJson(json.decode(response.body));
        print(list);
        notifyListeners();
      }
    } catch (error) {
      print(error.toString());
    }
  }
}

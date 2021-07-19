import 'dart:convert';

import 'package:falafel/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  Products list;

  get getProductsData => list;

  Future<Null> callAPIForProductsData() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://falafel.matsuda.website/api/product'),
      );
      int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 400 || json == null) {
      } else {
        list = Products.fromJson(json.decode(response.body));
        notifyListeners();

      }
    } catch (error) {
      print(error.toString());
    }
  }
}

import 'dart:convert';
import 'package:falafel/model/get_product_by_category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetProductByCategoryProvider with ChangeNotifier {
  ProductByCategory list;
  int counter;

  get getProductByCategory => list;

  Future<Null> callAPIForGetProductByCategory(String input) async {
    http.Response response = await http.get(
      Uri.parse('https://falafel.matsuda.website/api/product/bycategory/$input'),
    );
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      print('Error Calling Product By Category Id');
    } else {
      list = ProductByCategory.fromJson(json.decode(response.body));
      print(list);
      counter = list.productByCategory.length;
      print('Successfully Calling Product By Category Id');
      notifyListeners();
    }
  }
}

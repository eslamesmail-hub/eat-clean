import 'dart:convert';
import 'package:falafel/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  Category list;
  Category list2;

  get getCategoryData => list2;

  get getProductData => list;
  Category list3;
  get getSubCategory => list3;
  Future<Null> callAPIForCategoryData() async {
    http.Response response = await http.get(
      Uri.parse('https://falafel.matsuda.website/api/category'),
    );
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      print("Error Call API For all Category Data");
    } else {
      list = Category.fromJson(json.decode(response.body));
      print("All API for Category Data was called Successfully");
      notifyListeners();
    }
  }

  Future<Null> callForCategoryData(String id) async {
    http.Response response = await http.get(
      Uri.parse('https://falafel.matsuda.website/api/category/$id'),
    );
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      print("Error Call API For all Category Data");
    } else {
      list2 = Category.fromJson(json.decode(response.body));
      print("All API for Category Data was called Successfully");
      notifyListeners();
    }
  }
  Future<Null> callForSubCategory(String id) async {
    http.Response response = await http.get(
      Uri.parse('https://falafel.matsuda.website/api/category/$id'),
    );
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      print("Error Call API For all Category Data");
    } else {
      list3 = Category.fromJson(json.decode(response.body));
      print("All API for Category Data was called Successfully");
      notifyListeners();
    }
  }
}

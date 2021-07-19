import 'dart:convert';
import 'package:falafel/model/search_model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  Search list;
  int counter = 0;

  get getSearchData => list;

  Future callAPIForSearchData(String input) async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://falafel.matsuda.website/api/product/search/$input'),
      );
      list = Search.fromJson(json.decode(response.body));
      print(list);
      counter = list.data.length;
      print(counter);
      notifyListeners();
      return list;
    } catch (error) {
      print(error.toString());
    }
  }
}

import 'dart:convert';

import 'package:falafel/model/search_model.dart';

import 'package:http/http.dart' as http;

class SearchRequest {
  Future getCategory() async {
    String input;
    try {
      http.Response postResponse = await http
          .get(Uri.parse('https://falafel.matsuda.website/api/product/search/$input'));
      if (postResponse.statusCode == 200) {
        var responseObject = json.decode(postResponse.body);
        Search search = Search.fromJson(responseObject);
        print(responseObject);
        return search;
      } else {
        throw Exception("can't load search data");
      }
    } catch (error) {
      print(error.toString());
    }
  }
}

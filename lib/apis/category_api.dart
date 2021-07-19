import 'dart:convert';

import 'package:falafel/model/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryRequest {
  Future getCategory() async {
    try {
      http.Response postResponse =
          await http.get(Uri.parse('https://falafel.matsuda.website/api/category'));
      if (postResponse.statusCode == 200) {
        var responseObject = json.decode(postResponse.body);
        Category category = Category.fromJson(responseObject);
        print(responseObject);
        return category;
      } else {
        throw Exception("can't load category data");
      }
    } catch (error) {
      print(error.toString());
    }
  }
}

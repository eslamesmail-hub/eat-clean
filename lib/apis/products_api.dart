import 'dart:convert';

import 'package:falafel/model/products_model.dart';
import 'package:http/http.dart' as http;

class ProductsRequest {
  Future getProducts() async {
    try {
      http.Response postResponse =
          await http.get(Uri.parse('https://falafel.matsuda.website/api/product'));
      if (postResponse.statusCode == 200) {
        var responseObject = json.decode(postResponse.body);
        Products product = Products.fromJson(responseObject);
        print(responseObject);
        return product;
      } else {
        throw Exception("can't load search data");
      }
    } catch (error) {
      print(error.toString());
    }
  }
}

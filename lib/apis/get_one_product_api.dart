import 'dart:convert';
import 'package:falafel/model/get_one_product_model.dart';
import 'package:http/http.dart' as http;

class GetOneProductRequest {
  Future getOneProduct(String input) async {
    try {
      http.Response postResponse =
      await http.get(Uri.parse('https://falafel.matsuda.website/api/product/$input'));
      if (postResponse.statusCode == 200) {
        var responseObject = json.decode(postResponse.body);
        GetOneProduct oneProduct = GetOneProduct.fromJson(responseObject);
        print(responseObject);
        return oneProduct;
      } else {
        throw Exception("can't load category data");
      }
    } catch (error) {
      print(error.toString());
    }
  }
}

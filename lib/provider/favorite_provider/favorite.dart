import 'package:falafel/model/favorite_model.dart';
import 'package:falafel/provider/get_one_product_provider/one_product.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  Favorite list;
  var counter = 0;
  get getFavoriteData => list;

  Future<Null> callAPIForAllFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http.get(
      Uri.parse('https://falafel.matsuda.website/api/get_favorites'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      //Map<String, dynamic> mapResponse = json.decode(response.body);
      print('Error calling All Favorite Items');
    } else {
      list = Favorite.fromJson(json.decode(response.body));
      counter = list.favorite.length;
      print(counter);
      notifyListeners();
      print("Successfully Called API For All Favorites Items");
    }
  }

  Future<Null> addFavorite(String id, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http
        .post(Uri.parse('https://falafel.matsuda.website/api/add_favorite'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'id': id,
    });
    int statusCode = response.statusCode;
    var list = json.decode(response.body);
    print(list);
    print(response.statusCode);
    if (statusCode == 200) {
      Get.snackbar(list['message'], list['message']);
      print('Item added to favorites Successfully');
      Provider.of<GetOneProductProvider>(context,listen:false ).callAPIForGetOneProductData(id);

    } else {
      print(list);
      Get.snackbar(list['message'], list['message']);
      print('Error adding item to favorites');
    }
  }

  Future<void> deleteFavorite(String id , BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    var response = await http
        .post(Uri.parse('https://falafel.matsuda.website/api/remove_favorite'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "id": id,
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Favorite item deleted successfully');
      callAPIForAllFavorites();

      print(data);
    } else {
      print(response.body);
      print(response.statusCode);
      print("Can\'t  delete favorite item");
      notifyListeners();
    }
  }
}

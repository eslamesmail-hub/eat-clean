import 'package:falafel/model/orders_model.dart';
import 'package:falafel/screen/home/orderspage/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider with ChangeNotifier {
  Orders list;
  var counter = 0;

  get getOrderData => list;

  Future<Null> addOrder(String address, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http
        .post(Uri.parse('https://falafel.matsuda.website/api/add_order'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'address': address,
    });
    int statusCode = response.statusCode;
    var list = json.decode(response.body);
    print(list);
    print(response.statusCode);
    callAPIForAllOrders();
    if (statusCode == 200) {
      Get.snackbar(list['message'], list['message']);

      print('Order added Successfully');
      notifyListeners();
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: OrdersPage(),
        ),
      );
    } else {
      print(list);
      Get.snackbar(list['message'], list['message']);
      print("Error Can\'t add order");
    }
  }

  Future<Null> callAPIForAllOrders() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    http.Response response = await http.get(
      Uri.parse('https://bitna.club/api/get_orders'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
     // Map<String, dynamic> mapResponse = json.decode(response.body);
      print('Error calling All Orders API');
    } else {
      list = Orders.fromJson(json.decode(response.body));
      counter = list.data.length;
      print(counter);
      print("Success calling all orders API");
      notifyListeners();
    }
  }

  Future<void> deleteOrder(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    var response = await http
        .post(Uri.parse('https://bitna.club/api/remove_order'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      "id": id,
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Order deleted');
      callAPIForAllOrders();
      print(data);
    } else {
      print(response.body);
      print(response.statusCode);
      print("Could not delete order");
      notifyListeners();
    }
  }
}

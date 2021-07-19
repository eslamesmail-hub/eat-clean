// To parse this JSON data, do
//
//     final oneOrder = oneOrderFromJson(jsonString);

import 'dart:convert';

OneOrder oneOrderFromJson(String str) => OneOrder.fromJson(json.decode(str));

String oneOrderToJson(OneOrder data) => json.encode(data.toJson());

class OneOrder {
  OneOrder({
    this.message,
    this.data,
  });

  String message;
  Data data;

  factory OneOrder.fromJson(Map<String, dynamic> json) => OneOrder(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.orderCode,
    this.userId,
    this.state,
    this.address,
    this.total,
    this.date,
    this.products,
  });

  int orderCode;
  int userId;
  String state;
  String address;
  String total;
  DateTime date;
  List<Product> products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orderCode: json["order_code"],
    userId: json["user_id"],
    state: json["state"],
    address: json["address"],
    total: json["total"],
    date: DateTime.parse(json["date"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_code": orderCode,
    "user_id": userId,
    "state": state,
    "address": address,
    "total": total,
    "date": date.toIso8601String(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.productId,
    this.name,
    this.price,
    this.quantity,
    this.total,
    this.image,
  });

  int productId;
  String name;
  String price;
  String quantity;
  String total;
  String image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    name: json["name"],
    price: json["price"],
    quantity: json["quantity"],
    total: json["total"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "name": name,
    "price": price,
    "quantity": quantity,
    "total": total,
    "image": image,
  };
}

// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));

String ordersToJson(Orders data) => json.encode(data.toJson());

class Orders {
  Orders({
    this.message,
    this.data,
  });

  String message;
  List<Datum> data;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.orderCode,
    this.total,
    this.date,
  });

  int orderCode;
  String total;
  DateTime date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    orderCode: json["order_code"],
    total: json["total"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "order_code": orderCode,
    "total": total,
    "date": date.toIso8601String(),
  };
}

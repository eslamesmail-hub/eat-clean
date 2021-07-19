// To parse this JSON data, do
//
//     final rate = rateFromJson(jsonString);

import 'dart:convert';

Rate rateFromJson(String str) => Rate.fromJson(json.decode(str));

String rateToJson(Rate data) => json.encode(data.toJson());

class Rate {
  Rate({
    this.message,
    this.rate,
  });

  String message;
  List<Datum> rate;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
    message: json["message"],
    rate: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(rate.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.name,
    this.rate,
    this.content,
  });

  String name;
  String rate;
  String content;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    rate: json["rate"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "rate": rate,
    "content": content,
  };
}

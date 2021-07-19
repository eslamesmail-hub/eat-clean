// To parse this JSON data, do
//
//     final getOneProduct = getOneProductFromJson(jsonString);

import 'dart:convert';

GetOneProduct getOneProductFromJson(String str) => GetOneProduct.fromJson(json.decode(str));

String getOneProductToJson(GetOneProduct data) => json.encode(data.toJson());

class GetOneProduct {
  GetOneProduct({
    this.message,
    this.oneProduct,
  });

  String message;
  Data oneProduct;

  factory GetOneProduct.fromJson(Map<String, dynamic> json) => GetOneProduct(
    message: json["message"],
    oneProduct: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": oneProduct.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.description,
    this.imagePath,
    this.price,
    this.availableNumber,
    this.rating,
    this.ratingsNumber,
    this.categoryId,
    this.favorite,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String description;
  String imagePath;
  String price;
  String availableNumber;
  String rating;
  String ratingsNumber;
  String categoryId;
  String favorite;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imagePath: json["image_path"],
    price: json["price"],
    availableNumber: json["available_number"],
    rating: json["rating"],
    ratingsNumber: json["ratings_number"],
    categoryId: json["category_id"],
    favorite: json["favorite"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image_path": imagePath,
    "price": price,
    "available_number": availableNumber,
    "rating": rating,
    "ratings_number": ratingsNumber,
    "category_id": categoryId,
    "favorite": favorite,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

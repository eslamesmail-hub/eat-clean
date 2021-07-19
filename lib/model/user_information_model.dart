// To parse this JSON data, do
//
//     final userInformation = userInformationFromJson(jsonString);

import 'dart:convert';

UserInformation userInformationFromJson(String str) => UserInformation.fromJson(json.decode(str));

String userInformationToJson(UserInformation data) => json.encode(data.toJson());

class UserInformation {
  UserInformation({
    this.name,
    this.email,
    this.mobile,
    this.address,
  });

  String name;
  String email;
  String mobile;
  String address;

  factory UserInformation.fromJson(Map<String, dynamic> json) => UserInformation(
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "mobile": mobile,
    "address": address,
  };
}

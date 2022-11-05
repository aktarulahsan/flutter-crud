// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

// import 'package:floor/floor.dart';
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());
List<UserModel> userModelPostFromJson(var str) =>
    List<UserModel>.from(json.decode(str!).map((x) => UserModel.fromJson(x)));

// @entity
class UserModel {
  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    // this.address,
  });

  int? userId;
  String? firstName;
  String? lastName;
  // Address? address;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
    firstName: json["firstName"],
        lastName: json["lastName"],
        // address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        // "address": address!.toJson(),
      };
}

class Address {
  Address({
    this.addresId,
    this.userId,
    this.stree,
    this.city,
    this.state,
    this.zip,
  });

  int? addresId;
  int? userId;
  String? stree;
  String? city;
  String? state;
  int? zip;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addresId: json["addresId"],
        userId: json["userId"],
        stree: json["stree"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
      );

  Map<String, dynamic> toJson() => {
        "addresId": addresId,
        "userId": userId,
        "stree": stree,
        "city": city,
        "state": state,
        "zip": zip,
      };
}

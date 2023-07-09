// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? userId;
  String? username;
  String? email;
  String? imageUrl;
  Timestamp? creationDate;

  UserModel({
    this.userId,
    this.username,
    this.email,
    this.creationDate,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        imageUrl: json["imageUrl"],
        username: json["username"],
        email: json["email"],
        creationDate: json["creationDate"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "imageUrl": imageUrl,
        "email": email,
        "creationDate": creationDate,
      };
}

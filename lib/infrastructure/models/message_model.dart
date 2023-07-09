// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
    String? messageId;
    String? senderId;
    String? senderName;
    String? senderImageUrl;
    String  message;
    Timestamp? createdAt;

    MessageModel({
         required this.message,
         this.messageId,
         this.senderId,
         this.senderName,
         this.senderImageUrl,
         this.createdAt,
    });

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        messageId: json["messageId"],
        message: json["message"],
        senderId: json["senderId"],
        senderName: json["senderName"],
        senderImageUrl: json["senderImageUrl"],
        createdAt: json["createdAt"],
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "senderId": senderId,
        "message": message,
        "senderName": senderName,
        "senderImageUrl": senderImageUrl,
        "createdAt": createdAt,
    };
}

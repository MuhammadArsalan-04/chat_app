import 'package:chat_app/configs/backend.dart';
import 'package:chat_app/infrastructure/models/message_model.dart';
import 'package:chat_app/infrastructure/models/user_model.dart';
import 'package:chat_app/singleton/firebase_instance.dart';
import 'package:flutter/material.dart';

class MessageServices {
  static UserModel? _userDetails;
  Future<void> sendMessage(MessageModel message) async {
    try {
      final messageRef = Backend().kChatCollection.doc();
      final id = messageRef.id;

      message.messageId = id;
      //sendingMessage
      await messageRef.set(message.toJson());
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> getAndFetchUserDetails() async {
     await Backend().kUsersCollection.doc(Backend().uid).get().then((value) {
      _userDetails = UserModel.fromJson(value.data()!);
     },);

    
  }

  Stream<List<MessageModel>> getAndFetchMessages() {
    return Backend().kChatCollection.orderBy('createdAt',descending: true).snapshots().map((event) => event.docs.map((e) => MessageModel.fromJson(e.data())).toList());
  }

  static UserModel get getUserDetails => _userDetails!;
}

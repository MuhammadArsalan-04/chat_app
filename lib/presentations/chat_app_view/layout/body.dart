import 'package:chat_app/configs/backend.dart';
import 'package:chat_app/infrastructure/models/message_model.dart';
import 'package:chat_app/infrastructure/services/message_services.dart';
import 'package:chat_app/presentations/chat_app_view/layout/widgets/message_bubble.dart';
import 'package:chat_app/presentations/chat_app_view/layout/widgets/message_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final TextEditingController messageController = TextEditingController();
  bool isLoading = true;
  var fcm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.getToken().then((value) => fcm = value);

    // });
    Future.delayed(Duration.zero).then(
        (value) => MessageServices().getAndFetchUserDetails().then((value) {
              setState(() {
                isLoading = false;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: StreamBuilder(
                    stream: MessageServices().getAndFetchMessages(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : !snapshot.hasData
                              ? Container()
                              : ListView.builder(
                                  key: UniqueKey(),
                                  reverse: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) =>
                                      MessageBubble(
                                    isSentByMe: snapshot
                                            .data![index].senderId ==
                                        MessageServices.getUserDetails.userId,
                                    message: snapshot.data![index].message,
                                    senderImageUrl:
                                        snapshot.data![index].senderImageUrl,
                                    senderName:
                                        snapshot.data![index].senderName,
                                  ),
                                );
                    },
                  ),
                ),
              ),
              MessageField(
                  messageController: messageController, onPressed: sendMessage),
            ],
          );
  }

  void sendMessage() async {
    final MessageModel message = MessageModel(
      message: messageController.text.trim(),
      createdAt: Timestamp.now(),
      senderName: MessageServices.getUserDetails.username,
      senderId: MessageServices.getUserDetails.userId,
      senderImageUrl: MessageServices.getUserDetails.imageUrl,
    );
    MessageServices().sendMessage(message);

    messageController.clear();
  }
}

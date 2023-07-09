import 'package:chat_app/infrastructure/services/auth_services.dart';
import 'package:chat_app/presentations/chat_app_view/layout/body.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  static const routeName = "/chat-view";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chat",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
        ),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                value: "logout",
                child: Text(
                  "Logout",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            ],
            dropdownColor: Colors.white,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onChanged: (value) {
              AuthenticationServices().signUserOut(context);
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: ChatViewBody(),
      ),
    );
  }
}

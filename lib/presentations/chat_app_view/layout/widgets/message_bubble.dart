// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/configs/sizes.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isSentByMe;
  final String message;
  final String? senderName;
  final String? senderImageUrl;
  const MessageBubble({
    Key? key,
    required this.isSentByMe,
    required this.message,
    this.senderName,
    this.senderImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isSentByMe)
              CircleAvatar(
                radius: 10,
                backgroundImage: NetworkImage(senderImageUrl!),
              ),
            5.widthBox,
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.4),
              decoration: BoxDecoration(
                color: isSentByMe
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                    bottomLeft:
                        isSentByMe ? const Radius.circular(10) : Radius.zero,
                    bottomRight:
                        isSentByMe ? Radius.zero : const Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    senderName!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: !isSentByMe ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                  ),
                  10.heightBox,
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: !isSentByMe ? Colors.white : Colors.black,
                        ),
                  ),
                ],
              ),
            ),
            5.widthBox,
            if (isSentByMe)
              CircleAvatar(
                radius: 10,
                backgroundImage: NetworkImage(senderImageUrl!),
              ),
          ],
        ),
        10.heightBox,
      ],
    );
  }
}

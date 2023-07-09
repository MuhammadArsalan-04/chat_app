
import 'package:flutter/material.dart';

class MessageField extends StatefulWidget {
  final TextEditingController messageController;
  final VoidCallback onPressed;
  const MessageField({
    required this.messageController,
    required this.onPressed,
    super.key,
  });

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                  ),
              decoration: InputDecoration(
                label: Text(
                  "Send a message...",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              controller: widget.messageController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          IconButton(
            onPressed: widget.messageController.text.isEmpty ? null : widget.onPressed,
            icon: Icon(
              Icons.send,
              color: widget.messageController.text.isEmpty
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

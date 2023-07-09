import 'package:chat_app/configs/app_colors.dart';
import 'package:flutter/material.dart';

Future showAlertDialogue(BuildContext context, String title, String contentText,
    [Function? onPressed]) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      content: Text(
        contentText,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.black,
            ),
      ),
      title: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed == null
              ? () {
                  Navigator.pop(context);
                }
              : () => onPressed(),
          child: Text(
            "Okay",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.accentColor,
                ),
          ),
        ),
      ],
    ),
  );
}

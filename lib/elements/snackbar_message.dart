import 'package:flutter/material.dart';

import 'custom_text.dart';

showSnackBarMessage(BuildContext context, String message,
    [Color? snackBarColor]) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: snackBarColor ?? Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
        content: CustomText(
          text: message,
          color: Colors.white,
        ),
      ),
    );
}

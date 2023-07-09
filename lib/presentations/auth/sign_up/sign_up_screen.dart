import 'package:chat_app/presentations/auth/sign_up/layout/body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static const routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  SafeArea(
        child: SignUpViewBody(),
      ),
    );
  }
}
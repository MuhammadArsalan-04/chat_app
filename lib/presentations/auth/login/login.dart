import 'package:chat_app/presentations/auth/login/layout/body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: const LoginViewBody()),
    );
  }
}

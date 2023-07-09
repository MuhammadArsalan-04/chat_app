import 'package:chat_app/configs/app_colors.dart';
import 'package:chat_app/infrastructure/services/auth_services.dart';
import 'package:chat_app/presentations/auth/login/login.dart';
import 'package:chat_app/presentations/auth/sign_up/sign_up_screen.dart';
import 'package:chat_app/presentations/chat_app_view/chat_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: true, color: AppColors.primarySwatch, elevation: 0,),
        canvasColor: AppColors.backGroundColor,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: AppColors.primarySwatch,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            color: AppColors.primarySwatch,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.primarySwatch,
          backgroundColor: AppColors.backGroundColor,
          accentColor: AppColors.accentColor,
          brightness:
              ThemeData.estimateBrightnessForColor(AppColors.accentColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primarySwatch,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primarySwatch,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: AuthenticationServices().getAuthStateChanges(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : snapshot.hasData
                    ? const ChatView()
                    : const LoginView();
          }),
      routes: {
        LoginView.routeName: (context) => const LoginView(),
        SignUpView.routeName: (context) => const SignUpView(),
        ChatView.routeName: (context) => const ChatView(),
      },
    );
  }
}

import 'package:chat_app/configs/app_colors.dart';
import 'package:chat_app/configs/sizes.dart';
import 'package:chat_app/elements/custom_button.dart';
import 'package:chat_app/elements/custom_text.dart';
import 'package:chat_app/elements/custom_textfield.dart';
import 'package:chat_app/helper/navigation_helper.dart';
import 'package:chat_app/infrastructure/services/auth_services.dart';
import 'package:flutter/material.dart';

import '../../sign_up/sign_up_screen.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                20.heightBox,
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: AppColors.primarySwatch),
                ),
                10.heightBox,
                CustomTextField(
                  controller: _emailController,
                  labelText: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Provide email Address";
                    }

                    if (!value.contains("@")) {
                      return "Email is invalid";
                    }
                    return null;
                  },
                ),
                10.heightBox,
                CustomTextField(
                  isObsecure: true,
                  controller: _passwordController,
                  labelText: "Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Provide Password";
                    }

                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                10.heightBox,
                20.heightBox,
                CustomButton(
                  onPressed: () => submitLoginForm(),
                  buttonText: "Login",
                ),
                TextButton(
                  onPressed: () => navigateToSignUp(context),
                  child: const CustomText(
                    text: "Create a new account",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToSignUp(BuildContext context) {
    NavigationHelper.pushNamedReplacement(context, SignUpView.routeName);
  }

  void submitLoginForm() {
    final isValid = !_formKey.currentState!.validate();
    if (isValid) {
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
    }

    //login functionality here
    loginUser(context);
  }

  Future<void> loginUser(BuildContext context) async {
    //login functionality here
    await AuthenticationServices().loggingUserIn(
      context,
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }
}

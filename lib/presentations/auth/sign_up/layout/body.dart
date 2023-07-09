import 'dart:io';

import 'package:chat_app/configs/sizes.dart';
import 'package:chat_app/elements/snackbar_message.dart';
import 'package:chat_app/helper/navigation_helper.dart';
import 'package:chat_app/infrastructure/models/user_model.dart';
import 'package:chat_app/infrastructure/services/auth_services.dart';
import 'package:chat_app/presentations/auth/sign_up/layout/widget/user_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../configs/app_colors.dart';
import '../../../../elements/custom_button.dart';
import '../../../../elements/custom_text.dart';
import '../../../../elements/custom_textfield.dart';
import '../../login/login.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Form(
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
                    "Sign Up",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: AppColors.primarySwatch),
                  ),
                  20.heightBox,
                  UserImage(getCapturedImage),
                  20.heightBox,
                  CustomTextField(
                    controller: _usernameController,
                    labelText: "Username",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Provide Username";
                      }
                      if (value.length < 5) {
                        return "Username must be at least 5 characters";
                      }
                      return null;
                    },
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
                  isLoading
                      ? CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : CustomButton(
                          onPressed: () => submitSignUpForm(),
                          buttonText: "Sign Up",
                        ),
                  20.heightBox,
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Already Have an Account? ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: "Login",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => navigateToLogin(context),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentColor,
                            ),
                      ),
                    ]),
                  ),
                  20.heightBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToLogin(BuildContext context) {
    NavigationHelper.pushNamedReplacement(context, LoginView.routeName);
  }

  void submitSignUpForm() {
    final isFormValid = !_formKey.currentState!.validate();

    if (isFormValid) {
      debugPrint("Form is not valid");
      return;
    }

    if (_pickedImage == null) {
      showSnackBarMessage(context, "Please Pick An Image");
      return;
    }

    if (isFormValid) {
      _formKey.currentState!.save();
    }

    //sign up functionality here
    signUpUser();
  }

  Future<void> signUpUser() async {
    setState(() {
      isLoading = !isLoading;
    });

    UserModel userModel = UserModel(
      email: _emailController.text.trim(),
      username: _usernameController.text,
      creationDate: Timestamp.now(),
      
    );
    //sign up functionality here
    await AuthenticationServices()
        .registerUser(userModel.email!, _passwordController.text.trim(),
            userModel, _pickedImage! ,context)
        .then(
          (value) => setState(
            () {
              isLoading = !isLoading;
            },
          ),
        );
  }

  void getCapturedImage(File pickedImageFile) {
    _pickedImage = pickedImageFile;
  }
}

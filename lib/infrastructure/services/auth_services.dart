import 'dart:io';

import 'package:chat_app/configs/backend.dart';
import 'package:chat_app/helper/navigation_helper.dart';
import 'package:chat_app/infrastructure/models/user_model.dart';
import 'package:chat_app/presentations/auth/login/login.dart';
import 'package:chat_app/presentations/auth/sign_up/sign_up_screen.dart';
import 'package:chat_app/presentations/chat_app_view/chat_view.dart';
import 'package:chat_app/singleton/firebase_auth_instance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../elements/error_dialogue.dart';

class AuthenticationServices {
  Future<void> registerUser(String email, String password, UserModel userModel,
      File imageFile, BuildContext context) async {
    try {
      //authenticating user
      await FirebaseAuthInstance.firebaseAuthInstance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredentials) async{
        //adding user id to model
        userModel.userId = userCredentials.user!.uid;

        //uploading image to firebase storage
          final userImageRef = await uploadImageAndGetUrl(imageFile, userModel.userId!);

          userModel.imageUrl = userImageRef;

        //sending data to firestore
        Backend()
            .kUsersCollection
            .doc(userCredentials.user!.uid)
            .set(userModel.toJson());
      }).then((_) => showAlertDialogue(context, "Registered Successfully",
                  "Your Account Has Been Created Successfully", () {
                Navigator.pop(context);
                NavigationHelper.pushNamedReplacement(
                    context, LoginView.routeName);
              }));
    } on FirebaseAuthException catch (ex) {
      String error = '';

      //error handling for creating user
      switch (ex.code) {
        case 'email-already-in-use':
          error = "Account with this email already exists";
          break;
        case 'invalid-email':
          error = "invalid email address provided";
          break;
        case 'operation-not-allowed':
          error = "The email Accounts Were Disabled or Removed";
          break;
        case "weak-password":
          error = ex.message!;
          break;
        default:
          error = "Something went wrong please check your internet connection";
      }
      showAlertDialogue(context, "Registration Failed", error);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  //login user
  Future<void> loggingUserIn(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuthInstance.firebaseAuthInstance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((_) => NavigationHelper.pushNamedReplacement(
              context, ChatView.routeName));
    } on FirebaseAuthException catch (authEx) {
      String errorMessage = '';
      if (authEx.code == 'user-not-found') {
        errorMessage = 'No User Found with this email and password';
      }
      if (authEx.code == 'invalid-email') {
        errorMessage = 'Invalid email or password provided';
      }
      if (authEx.code == 'wrong-password') {
        errorMessage = 'The password you entered was incorrect';
      }

      showAlertDialogue(context, "Login Failed",
          errorMessage == '' ? authEx.message! : errorMessage);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> signUserOut(BuildContext context) async {
    try {
      await FirebaseAuthInstance.firebaseAuthInstance.signOut().then((_) =>
          NavigationHelper.pushNamedReplacement(context, LoginView.routeName));
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Stream<User?> getAuthStateChanges() {
    return FirebaseAuthInstance.firebaseAuthInstance.authStateChanges();
  }

  Future<String?> uploadImageAndGetUrl(File imageFile, String userId) async {
    String? imageUrl;
    try {
      //creating an image path reference
      final ref =
          Backend().kStorageRef.child("user_images").child("$userId.jpg");

      //uploading image to firebase storage
      final uploadTask = await ref.putFile(imageFile);

      //getting image url
      imageUrl = await uploadTask.ref.getDownloadURL();

      return imageUrl;
    } catch (err) {
      debugPrint(err.toString());
    }
    return imageUrl;
  }
}

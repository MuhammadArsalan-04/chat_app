import 'package:chat_app/singleton/firebase_auth_instance.dart';
import 'package:chat_app/singleton/firebase_instance.dart';
import 'package:chat_app/singleton/firebase_storage_instance.dart';

class Backend {
   final kUsersCollection =
      FirebaseInstance.firebaseInstance.collection('users');

   final kChatCollection =  FirebaseInstance.firebaseInstance.collection('chat');
   String uid = FirebaseAuthInstance.firebaseAuthInstance.currentUser!.uid;

   final kStorageRef = FirebaseStorageInstance.firebaseInstance.ref() ;
}


import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageInstance{

  static final FirebaseStorage _firebaseInstance = FirebaseStorage.instance;

  FirebaseStorageInstance._privateConstructor();
  ///Getter of Firebase Firestore Instance
  static FirebaseStorage get firebaseInstance => _firebaseInstance;
}
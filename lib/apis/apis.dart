
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  //Firebase Storage instance for storing files and images
  static FirebaseStorage storage = FirebaseStorage.instance;
  static User get user => auth.currentUser!;
  }

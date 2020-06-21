import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManagement {
  storeNewUser(user, context) => Firestore.instance
      .collection("/users").document(user.user.uid)
      .setData({
        "email": user.user.email,
      })
      .then((value) => print("User stored Success"))
      .catchError((onError) => print(onError));
}

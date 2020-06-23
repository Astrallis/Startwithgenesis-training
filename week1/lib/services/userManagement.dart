import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week1/presentation/sign_in_success.dart';

class UserManagement {
  Future<bool> storeDataForPersistance(userData) async {
    print("Storage Started");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Signed In", true);
    prefs.setString("Full Name", userData.fullName);
    prefs.setString("Email", userData.email);
    prefs.setString("Mobile", userData.mobile);
    prefs.setString("Image URL", userData.imgUrl);
    print("Storage Completed");
    return true;
  }

  Future<bool> storeDataForPersistanceFromLogin(userData) async {
    print("Storage Started");
    print(userData['name']);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Signed In", true);
    prefs.setString("Full Name", userData['name']);
    prefs.setString("Email", userData['email']);
    prefs.setString("Mobile", userData['mobile']);
    prefs.setString("Image URL", userData['img'] == null ? "empty" : userData['img']);
    print("Storage Completed");
    return true;
  }

  // getUser(userId, context) => print(Firestore.instance.collection("/users").document(userId).get());

  getUser(userId, context) =>
      Firestore.instance.collection("/users").document(userId).get().then(
            (doc) => storeDataForPersistanceFromLogin(doc).then(
              (value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignedIn(),
                ),
              ),
            ).catchError((onError) => print(onError)),
          );

  storeNewUser(user, context, {userData}) => Firestore.instance
      .collection("/users")
      .document(user.user.uid)
      .setData({
        "email": user.user.email,
        "name": userData.fullName,
        "mobile": userData.mobile,
        "img": userData.imgUrl,
      })
      .then((value) => {
            storeDataForPersistance(userData).then((value) =>
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignedIn())))
          })
      .catchError((onError) => print(onError));
}

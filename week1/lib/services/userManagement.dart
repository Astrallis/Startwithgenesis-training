import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week1/main.dart';
import 'package:week1/models/user_model.dart';
import 'package:week1/presentation/login.dart';
import 'package:week1/presentation/otp_screen.dart';
import 'package:week1/presentation/profile_pic_screen.dart';
import 'package:week1/presentation/sign_in_success.dart';

class UserManagement {
  Future<UserModel> getUserDataFromPersistance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Signed In', true);
    UserModel temp = new UserModel(
      fullName: prefs.getString("Full Name"),
      email: prefs.getString("Email"),
      mobile: prefs.getString("Mobile"),
      imgUrl: prefs.getString("Image URL"),
    );
    return temp;
  }

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
    prefs.setString(
        "Image URL", userData['img'] == null ? "empty" : userData['img']);
    print("Storage Completed");
    return true;
  }

  //get user from database
  getUser(userId, context) =>
      Firestore.instance.collection("/users").document(userId).get().then(
            (doc) => storeDataForPersistanceFromLogin(doc)
                .then(
                  (value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignedIn(),
                    ),
                  ),
                )
                .catchError(
                  (onError) => print(onError),
                ),
          );

  //Store user in data base
  storeNewUser(user, context, {userData, bool isGmail = false}) =>
      Firestore.instance
          .collection("/users")
          .document(user.user.uid)
          .setData({
            "email": user.user.email,
            "name": userData.fullName,
            "mobile": userData.mobile,
            "img": userData.imgUrl,
          })
          .then((value) => {
                storeDataForPersistance(userData).then(
                  (value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignedIn(),
                    ),
                  ),
                ),
              })
          .catchError(
            (onError) => print(onError),
          );

  //store new user via gmail
  storeNewUserViaGmail(context, {userData}) => Firestore.instance
      .collection("/users")
      .document(userData.email)
      .setData({
        "email": userData.email,
        "name": userData.fullName,
        "mobile": userData.mobile,
        "img": userData.imgUrl,
      })
      .then((value) => {
            storeDataForPersistance(userData).then(
              (value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignedIn(),
                ),
              ),
            ),
          })
      .catchError(
        (onError) => print(onError),
      );

  //sign in with google
  signInWithGoogle(context) async {
    Fluttertoast.showToast(
        msg: "Signing in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.white,
        fontSize: 16.0);
    final GoogleSignInAccount googleSignInAccount =
        await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    print(user.displayName + " " + user.email);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);
    UserModel _user = new UserModel(
        fullName: user.displayName,
        email: user.email,
        imgUrl: user.photoUrl,
        mobile: user.phoneNumber);
    storeNewUserViaGmail(context, userData: _user)
        .then(
          () => Fluttertoast.showToast(
              msg: "Sign in successfull",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0),
        )
        .catchError(
          (e) => Fluttertoast.showToast(
              msg: e.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0),
        );
    return 'signInWithGoogle succeeded: $user';
  }

  loginUserMobile(String phone, BuildContext context) async {
    Fluttertoast.showToast(
        msg: "Sending OTP For verification",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.white,
        fontSize: 16.0);
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;
          Fluttertoast.showToast(
              msg: "Trying Auto Auth",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.yellow,
              textColor: Colors.white,
              fontSize: 16.0);
          if (user != null)
           {
            Fluttertoast.showToast(
                msg:
                    "User Signed in Via Auto Auth, Please Enter your details to proceed",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            final snapShot = await Firestore.instance
                .collection('users')
                .document(user.uid)
                .get();
            if (snapShot == null || !snapShot.exists)
            {
              UserModel _user = UserModel(mobile: phone);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileUpdate(_user, user.uid, true),
                ),
              );
            }
            else
              getUser(user.uid, context);
          }
          else 
          {
            Fluttertoast.showToast(
                msg: "Auto Auth Failed, Try entering the OTP Manually",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(verificationId, phone),
            ),
          );
        },
        codeAutoRetrievalTimeout: null);
  }

  otpVerif(String phone, String codetext, verificationId, context) async {
    final code = codetext.trim();
    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);
    AuthResult result = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((e) => Fluttertoast.showToast(
            msg: e.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0));
    FirebaseUser user = result.user;
    if (user != null) {
      Fluttertoast.showToast(
          msg: "User Signed in",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print(user.uid);
      final snapShot =
          await Firestore.instance.collection('users').document(user.uid).get();
      if (snapShot == null || !snapShot.exists) {
        UserModel _user = UserModel(mobile: phone);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileUpdate(_user, user.uid, true),
          ),
        );
      } else
        getUser(user.uid, context);
    } else {
      Fluttertoast.showToast(
          msg: "Some Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  passwordResetEmail(String email, context) {
    return FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) => {
              Fluttertoast.showToast(
                  msg:
                      "We have sent a password reset link on the email address, please change the password and login again",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 4,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0),
              Navigator.pop(context)
            })
        .catchError((e) => Fluttertoast.showToast(
            msg: e.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0));
  }

  logOut(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Signed In", false);
    prefs.setString("Full Name", null);
    prefs.setString("Email", null);
    prefs.setString("Mobile", null);
    prefs.setString("Image URL", null);
    GoogleSignIn().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(),
      ),
    );
  }
}

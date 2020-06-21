import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:week1/services/userManagement.dart';
import 'package:week1/tester_pages/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              textAlign: TextAlign.center,
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              textAlign: TextAlign.center,
              controller: passController,
              decoration: InputDecoration(
                labelText: "Pass",
              ),
            ),
            SizedBox(height: 30),
            FlatButton(
                onPressed: () => FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text)
                        .then((signedInUser) {
                      UserManagement().storeNewUser(signedInUser, context);
                      Fluttertoast.showToast(
                            msg: "User Account Created",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                    }).catchError((onError) => Fluttertoast.showToast(
                            msg: onError.message,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0)),
                child: Text("Sign in")),
            FlatButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    )),
                child: Text("Login")),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:week1/tester_pages/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            FlatButton(onPressed: () => FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passController.text).then((user)=>print("LOGIN HO GYA")).catchError((e)=>print(e)), child: Text("Sign in")),
            FlatButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    )),
                child: Text("Sign up")),
          ],
        ),
      ),
    );
  }
}

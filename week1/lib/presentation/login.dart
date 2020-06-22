import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:week1/presentation/login_base_page.dart';
import 'package:week1/services/userManagement.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  _login() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passController.text)
        .then((user) => {UserManagement().getUser(user.user.uid, context)})
        .catchError((e) => print(e));
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool obscure;
  @override
  void initState() {
    obscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginBasePage(
      topCardContent: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, top: 40),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  labelText: "Email",
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextFormField(
                obscureText: obscure,
                controller: passController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() {
                      obscure = !obscure;
                    }),
                    child: obscure
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                  labelText: "Password",
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                "Forgot Password?",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFFBB034),
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                "Login using Mobile no. and OTP",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Align(
                alignment: Alignment(1, 1),
                child: FloatingActionButton(
                  onPressed: () => _login(),
                  backgroundColor: Color(0xFFFBB034),
                  child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Firestore.instance.collection("/users").document("Vk7diwQXumYxizUJIuvXcMElF7J2").get().then((doc)=>print(doc.data));

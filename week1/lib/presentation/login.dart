import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:week1/presentation/forgot_password.dart';
import 'package:week1/presentation/login_base_page.dart';
import 'package:week1/presentation/phone_no_login.dart';
import 'package:week1/services/userManagement.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool obscure;

  loginWithEmailPassword( context ,{String email, String pass}) {
    Fluttertoast.showToast(
        msg: "Signing in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.white,
        fontSize: 16.0);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) => {
              UserManagement().getUser(user.user.uid, context),
              Fluttertoast.showToast(
                  msg: "Sign in Successfull",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0),
            })
        .catchError((e) => {
          setState((){isLoading = false;}),
              Fluttertoast.showToast(
                  msg: e.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0),
            });
  }

  @override
  void initState() {
    isLoading = false;
    obscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LoginBasePage(
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
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword())),
                  child: Container(
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
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MobileLogin())),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "Login using Mobile no. and OTP",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Align(
                    alignment: Alignment(1, 1),
                    child: FloatingActionButton(
                      onPressed: () {
                        if (emailController.text.isEmpty ||
                            passController.text.isEmpty)
                          Fluttertoast.showToast(
                              msg: "Please enter all details first",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        else {
                          setState(() {
                            isLoading = true;
                          });
                          loginWithEmailPassword(context,
                                  email: emailController.text,
                                  pass: passController.text)
                              .then(() => setState(() {
                                    isLoading = false;
                                  }));
                          
                        }
                      },
                      
                      backgroundColor: Color(0xFFFBB034),
                      child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(),
      ],
    );
  }
}

// Firestore.instance.collection("/users").document("Vk7diwQXumYxizUJIuvXcMElF7J2").get().then((doc)=>print(doc.data));

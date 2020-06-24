import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week1/models/user_model.dart';
import 'package:week1/presentation/login_base_page.dart';
import 'package:week1/presentation/otp_screen.dart';
import 'package:week1/presentation/profile_pic_screen.dart';
import 'package:week1/services/userManagement.dart';
import 'package:week1/tester_pages/signup.dart';

import '../main.dart';

class MobileLogin extends StatefulWidget {
  @override
  _MobileLoginState createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  TextEditingController mobileController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoginBasePage(
      isOtp: true,
      topCardContent: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30.0, top: 80, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter Phone Number", style: TextStyle(color: Colors.black45)),
            TextField(
              controller: mobileController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.flag),
                prefix: Text("+91 ", style: TextStyle(color: Colors.black45)),
                labelText: "Phone no.",
              ),
            ),
            SizedBox(height: 10),
            Text("We will send you an One Time Password on this no.", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
            SizedBox(height: 30,),
            Text("Login using Email and Password", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, decoration: TextDecoration.underline)),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Align(
                alignment: Alignment(1, 1),
                child: FloatingActionButton(
                  onPressed: () {
                UserManagement().loginUserMobile("+91" + mobileController.text, context)
                    .then((value) => print("khatam"));
              },
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

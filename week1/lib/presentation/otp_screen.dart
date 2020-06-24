import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:week1/presentation/login_base_page.dart';
import 'package:week1/services/userManagement.dart';

class OtpScreen extends StatefulWidget {
  String verificationId;
  String phone;
  OtpScreen(String verificationId, String phone) {
    this.verificationId = verificationId;
    this.phone = phone;
  }
  @override
  _OtpScreenState createState() => _OtpScreenState(verificationId, phone);
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController codeController = new TextEditingController();
  String verificationId;
  String phone;
  _OtpScreenState(String verificationId, String phone) {
    this.verificationId = verificationId;
    this.phone = phone;
  }
  @override
  Widget build(BuildContext context) {
    return LoginBasePage(
        topCardContent: Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 40),
      child: Column(
        children: [
          Text("Enter The OTP Sent to $phone"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextFormField(controller: codeController),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("We will send you an One Time Password on this no.", textAlign: TextAlign.center ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: 20,),
          Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Align(
                alignment: Alignment(1, 1),
                child: FloatingActionButton(
                  onPressed: () {UserManagement().otpVerif(phone, codeController.text, verificationId, context);},
                  backgroundColor: Color(0xFFFBB034),
                  child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    ));
  }
}

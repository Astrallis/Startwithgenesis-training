import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:week1/presentation/login_base_page.dart';
import 'package:week1/services/userManagement.dart';

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
        padding:
            const EdgeInsets.only(right: 30, left: 30.0, top: 80, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter Phone Number", style: TextStyle(color: Colors.black45)),
            TextField(
              maxLength: 10,
              keyboardType: TextInputType.numberWithOptions(),
              controller: mobileController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.flag),
                prefix: Text(
                  "+91 ",
                  style: TextStyle(color: Colors.black45),
                ),
                labelText: "Phone no.",
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We will send you an One Time Password on this no.",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Login using Email and Password",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline)),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Align(
                alignment: Alignment(1, 1),
                child: FloatingActionButton(
                  onPressed: () {
                    if (mobileController.text.length != 10 ||
                        mobileController.text.isEmpty)
                      Fluttertoast.showToast(
                          msg: "Please enter a valid phone no.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    else
                      UserManagement()
                          .loginUserMobile(
                              "+91" + mobileController.text, context)
                          .then((value) => print("No. verified"));
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

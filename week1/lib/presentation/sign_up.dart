import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:week1/enums/userRole.dart';
import 'package:week1/models/user_model.dart';
import 'package:week1/presentation/sign_in_success.dart';
import 'package:week1/services/userManagement.dart';
import 'package:week1/shared/page_wrap.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController passConfController = new TextEditingController();
  bool isChecked;

  _createUser() {
    UserModel _user = new UserModel(
        fullName: nameController.text,
        email: emailController.text,
        mobile: phoneController.text,
        userRole: UserRole.DEFAULT_USER);
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _user.email, password: passController.text)
        .then((signedInUser) {
      UserManagement().storeNewUser(signedInUser, context, userData: _user);
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
            fontSize: 16.0));
  }

  @override
  void initState() {
    isChecked = false; // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
              )
            ]),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Name",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
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
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: "Phone no.",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: TextField(
                  obscureText: true,
                  controller: passController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: TextField(
                  controller: passConfController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Confirm Password",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  children: [
                    Checkbox(
                        activeColor: Color(0xFFFBB034),
                        checkColor: Colors.white,
                        value: isChecked,
                        onChanged: (value) => setState(() {
                              isChecked = value;
                              print(isChecked);
                            })),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                            "I agree to Terms and Conditions and Privacy Policies"))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _createUser,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFBB034),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      "Proceed",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      name: "SIGN UP",
    );
  }
}

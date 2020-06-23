import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week1/models/user_model.dart';
import 'package:week1/services/userManagement.dart';
import 'package:week1/shared/page_wrap.dart';

class ProfileUpdate extends StatefulWidget {
  UserModel user;
  String password;
  ProfileUpdate(UserModel user, String password){
    this.user =user;
    this.password =password;
  }
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState(user, password);
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  String password;
  UserModel user;
  _ProfileUpdateState(UserModel user, String password){
    this.user = user;
    this.password = password;
  }
  File img;

  // FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(
  //           email: _user.email, password: passController.text)
  //       .then((signedInUser) {
  //     UserManagement().storeNewUser(signedInUser, context, userData: _user);
  //     Fluttertoast.showToast(
  //         msg: "User Account Created",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.TOP,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }).catchError((onError) => Fluttertoast.showToast(
  //           msg: onError.message,
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.TOP,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0));

  _signUp(UserModel user) async {
    print(user.fullName);
    if (img != null) {
      print("in if");
      final StorageReference storageRef =
          FirebaseStorage.instance.ref().child(user.email);
      final StorageUploadTask uploadTask = storageRef.putFile(img);
      final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
      final String url = (await downloadUrl.ref.getDownloadURL());
      print(url+" upload ho gya");
      user.imgUrl = url;
    }
      print("if paar");
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email, password: widget.password)
        .then((signedInUser) {
      UserManagement().storeNewUser(signedInUser, context, userData: user);
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

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      img = image;
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 70,
              child: Column(
                children: [
                  Text("Choose your profile picture"),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        FlatButton(
                            onPressed: () => getImage(true),
                            child: Icon(Icons.camera)),
                        FlatButton(
                            onPressed: () => getImage(false),
                            child: Icon(Icons.photo_album)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    print("Sign up page print "+ user.fullName);
    emailController.text = user.email == null? "": user.email;
    nameController.text = user.fullName == null? "": user.fullName; // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      name: "COMPLETE YOUR PROFILE",
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _showDialog,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: img != null
                                ? FileImage(img)
                                : NetworkImage(
                                    "https://irishrsa.ie/wp-content/uploads/2017/03/default-avatar-300x300.png")),
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  ),
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
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => _signUp(user),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFFBB034),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          "PROCEED",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

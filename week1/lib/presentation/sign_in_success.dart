import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week1/models/user_model.dart';
import '../main.dart';

class SignedIn extends StatefulWidget {
  @override
  _SignedInState createState() => _SignedInState();
}

class _SignedInState extends State<SignedIn> {
  UserModel user = new UserModel();

  Future<UserModel> getUser() async {
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

  _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Signed In", false);
    prefs.setString("Full Name", null);
    prefs.setString("Email", null);
    prefs.setString("Mobile", null);
    prefs.setString("Image URL", null);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
    print(user.fullName);
    getUser().then((value) => setState(() {
          user = value;
          print(user.imgUrl);
        }));
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user.fullName == null
          ? CircularProgressIndicator()
          : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Text(user.fullName),
                        Text(user.email),
                        Text(user.mobile),
                        Container(height: 200,width: 200, decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: user.imgUrl.compareTo("empty") == 0
                              ? NetworkImage(
                                  "https://irishrsa.ie/wp-content/uploads/2017/03/default-avatar-300x300.png")
                              : NetworkImage(user.imgUrl), fit: BoxFit.cover
                        ))),
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: _logOut,
                    child: Text("LogOut"),
                  ),
                ],
              ),
          ),
    );
  }
}

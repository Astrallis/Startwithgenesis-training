import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week1/presentation/forgot_password.dart';
import 'package:week1/presentation/profile_pic_screen.dart';
import 'package:week1/presentation/sign_in_success.dart';
import 'package:week1/presentation/sign_up.dart';
import 'package:week1/shared/page_wrap.dart';
import 'package:week1/presentation/login.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        fontFamily: "Montserrat",
        accentColor: Color(0xfffbb034),
        primaryColor: Color(0xfffbb034),
      ),
      home: SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new MyApp(),
      title: Text(" ",),
      image: new Image.asset('assets/logo.png'),
      backgroundColor: Color(0xfffbb034),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.transparent
    ),),);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoadingPersistance;
  bool isSignedIn;
  String name;

  Future<bool> logOut(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Signed In", false);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    return false;
  }

  Future<bool> getUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool signedIn = prefs.getBool('Signed In');
    if (signedIn == null) signedIn = false;
    if (signedIn == true)
      setState(() {
        name = prefs.getString("Full Name");
      });
    return signedIn;
  }

  @override
  initState() {
    name = "";
    isLoadingPersistance = true;
    getUserStatus().then((value) => {
          setState(() {
            isLoadingPersistance = false;
            isSignedIn = value;
            print(isSignedIn);
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingPersistance
          ? Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFFBB034), Color(0xFFFFEE11)],
                      begin: FractionalOffset(0.8, 0.0),
                      end: FractionalOffset(0.0, 0.2),
                      stops: [0.0, 1.5],
                      tileMode: TileMode.clamp),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : isSignedIn
              ? SignedIn()
              : LoginPage();
  }
}

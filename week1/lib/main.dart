import 'package:flutter/material.dart';
import 'package:week1/shared/page_wrap.dart';
import 'package:week1/tester_pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      theme: ThemeData(
        fontFamily: "Montserrat",
        accentColor: Color(0xfffbb034),
        primaryColor: Color(0xfffbb034),
      ),
      home: LoginPage()
    );
  }
}

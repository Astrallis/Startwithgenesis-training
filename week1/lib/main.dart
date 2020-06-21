import 'package:flutter/material.dart';
import 'package:week1/shared/page_wrap.dart';

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
      home: PageWrap(name: "LOGIN", child: Container(height: 500,width: 900,color: Colors.red,)),
    );
  }
}

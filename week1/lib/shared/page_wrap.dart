import 'package:flutter/material.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:supercharged/supercharged.dart';

class PageWrap extends StatelessWidget {
  final String name;
  final Widget child;

  PageWrap({@required this.name, @required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            MirrorAnimation<double>(
              tween: (0.0).tweenTo(1.0),
              duration: 5.seconds, // <-- mandatory
              builder: (context, child, value) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFFFBB034), Color(0xFFFFEE11)],
                        begin: FractionalOffset(value, 0.0),
                        end: FractionalOffset(0.0, 1 - value),
                        stops: [0.0, 1.5],
                        tileMode: TileMode.clamp),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment(0, -0.98),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset("assets/logo.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: child,
                    ), //Child Widget Passed through Params
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:week2/presentation/landing_components/trending.dart';

import 'landing_components/category.dart';
import 'landing_components/featured.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.account_balance,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0x11000000),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.account_balance,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CategoryList(),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Trending",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.graphic_eq)
                ],
              ),
              Trending(),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Featured",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.card_membership)
                ],
              ),
              Featured()
            ],
          ),
        ),
      ),
    );
  }
}

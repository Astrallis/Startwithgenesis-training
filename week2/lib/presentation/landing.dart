import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'landing_components/category.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          CategoryList()
        ],
      ),
    );
  }
}

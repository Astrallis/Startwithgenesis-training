import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:week2/presentation/landing_components/trending.dart';

import 'after_search/search.dart';
import 'landing_components/category.dart';
import 'landing_components/featured.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  TextEditingController controller = new TextEditingController();
  FocusNode focusser;
  @override
  void initState() {
    focusser = new FocusNode(); // TODO: implement initState
    super.initState();
  }

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
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: ExactAssetImage("assets/logo.png"),
                              fit: BoxFit.cover)),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 6),
                            child: TextField(
                              controller: controller,
                              onChanged: (value) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: "Search",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0x00000000)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0x00000000)),
                                ),
                              ),
                              focusNode: focusser,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ]),
                      child: Icon(Icons.select_all),
                    ),
                    SizedBox(
                      width: 2,
                    )
                  ],
                ),
              ),
              focusser.hasFocus && controller.text.length > 0
                  ? Center(
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Search " + controller.text + "...",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchComponent(
                                            search: controller.text,
                                          ))),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  child: Text(
                                    "YES",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
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

import 'package:flutter/material.dart';
import 'package:week1/models/user_model.dart';
import 'package:week1/services/userManagement.dart';

class SignedIn extends StatefulWidget {
  @override
  _SignedInState createState() => _SignedInState();
}

class _SignedInState extends State<SignedIn> {
  UserModel user = new UserModel();

  @override
  void initState() {
    super.initState();
    setState(() {});
    print(user.fullName);
    UserManagement().getUserDataFromPersistance().then((value) => setState(() {
          user = value;
          print(user.imgUrl);
        }));
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: Icon(Icons.exit_to_app, color: Colors.white),
            onTap: () => UserManagement().logOut(context),
          ),
          Container(
            width: 15,
          )
        ],
        leading: Icon(Icons.menu, color: Colors.white),
      ),
      body: user.fullName == null
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 5)),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          children: [
                            Container(
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          ExactAssetImage("assets/logo.png"))),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            Text("First Challenge Completed")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          "Currently Logged in as :-",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 5)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: user.imgUrl == null
                                        ? NetworkImage(
                                            "https://irishrsa.ie/wp-content/uploads/2017/03/default-avatar-300x300.png")
                                        : NetworkImage(user.imgUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.fullName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.45,
                                        child: Text(
                                          user.email,
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),),
                                  ),
                                  // Text("+91 "+user.mobile, style: TextStyle(
                                  //             color: Colors.black12,
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 14),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Card(
                    //   clipBehavior: Clip.antiAlias,
                    //   child: Column(
                    //     children: [

                    //       Container(
                    //           height: 200,
                    //           width: 200,
                    //           decoration: BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               image: DecorationImage(
                    //                   image: user.imgUrl.compareTo("empty") == 0
                    //                       ? NetworkImage(
                    //                           "https://irishrsa.ie/wp-content/uploads/2017/03/default-avatar-300x300.png")
                    //                       : NetworkImage(user.imgUrl),
                    //                   fit: BoxFit.cover))),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}

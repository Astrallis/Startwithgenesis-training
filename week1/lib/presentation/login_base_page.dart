import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:week1/models/user_model.dart';
import 'package:week1/services/userManagement.dart';
import 'package:week1/shared/page_wrap.dart';
import 'package:week1/presentation/sign_up.dart';

class LoginBasePage extends StatefulWidget {
  final Widget topCardContent;
  final bool isOtp;
  LoginBasePage({
    @required this.topCardContent,
    this.isOtp = false
  });
  @override
  _LoginBasePageState createState() => _LoginBasePageState();
}

class _LoginBasePageState extends State<LoginBasePage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  print(user.displayName+" "+user.email);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  assert(user.uid == currentUser.uid);
    UserModel _user =new UserModel(fullName: user.displayName, email: user.email, imgUrl: user.photoUrl, mobile: user.phoneNumber);
    UserManagement().storeNewUserViaGmail(context, userData: _user);
    print("New User Created");
 
  return 'signInWithGoogle succeeded: $user';
}
  
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      name: widget.isOtp?"OTP VERIFICATION":"LOGIN",
      child: Column(
        children: [
          ClipPath(
            clipper: BottomClipper(),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child:  widget.topCardContent
              
            ),
          ),
          ClipPath(
            clipper: TopClipper(),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "OR",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Login with social media",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 30,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap:()=> GoogleSignIn().signOut(),
                                                      child: Image(
                              image: ExactAssetImage("assets/facebook.png"),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          GestureDetector(
                            onTap:() => 
                            signInWithGoogle(),
                            
                                                      child: Image(
                              image: ExactAssetImage("assets/google.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  GestureDetector(
                        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp())),
                        child: Text("Click here to Sign up",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        )),
                  )
                ],
              ),
          )
        ],
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 30, size.height);
    path.lineTo(30, size.height - 50);
    path.arcToPoint(Offset(0, size.height - 80), radius: Radius.circular(30));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 30);
    path.arcToPoint(Offset(30, 0), radius: Radius.circular(30));
    path.lineTo(size.width - 30, 50);
    path.arcToPoint(Offset(size.width, 80), radius: Radius.circular(30));
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

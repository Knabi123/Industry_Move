// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, deprecated_member_use, unused_local_variable, avoid_print

import 'package:company/src_user/bottombar_user.dart';
import 'package:flutter/material.dart';
import 'package:company/src_user/register.dart';
import 'package:company/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          '791240127140-foosi28muhfk9lg2icjv259f0caijkqs.apps.googleusercontent.com');

  @override
  Widget build(BuildContext context) {
    // final currentUser = FirebaseAuth.instance.currentUser;
    // if (currentUser != null) {
    //   return BottomBar_User();
    // }
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[100],
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    height: 275,
                    width: width + 20,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 310,
                    width: width + 40,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background-2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: 'Kanit-Black',
                      color: Color.fromRGBO(49, 39, 79, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3),
                          blurRadius: 20,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: TextField(
                            controller: idController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: passwordController,
                            obscuringCharacter: '*',
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        String id = idController.text;
                        String password = passwordController.text;

                        bool loginSuccess =
                            await FirestoreService.login(id, password, context);

                        if (!loginSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invalid username or password'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        minimumSize: Size(250, 60),
                      ),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      child: Text('Create Account'),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => RegisterForm(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _loginWithFacebook,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white54,
                          ),
                          child: Image.asset(
                            'assets/images/facebook.png', // รูป Google
                            height: 40,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                          onTap: () async {
                            try {
                              final GoogleSignInAccount? googleUser =
                                  await GoogleSignIn().signIn();
                              if (googleUser != null) {
                                final GoogleSignInAuthentication googleAuth =
                                    await googleUser.authentication;
                                final OAuthCredential credential =
                                    GoogleAuthProvider.credential(
                                  accessToken: googleAuth.accessToken,
                                  idToken: googleAuth.idToken,
                                );
                                final UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .signInWithCredential(credential);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomBar_User()),
                                );
                              } else {
                                print("Sign in with Google canceled.");
                              }
                            } catch (e) {
                              print("Error signing in with Google: $e");
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white54,
                            ),
                            child: Image.asset(
                              'assets/images/gmail.png',
                              height: 40,
                            ),
                          )),
                      SizedBox(width: 20),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white54,
                        ),
                        child: Image.asset(
                          'assets/images/instagram.png',
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomBar_User()),
        );
      } else {
        print("Facebook login failed.");
      }
    } catch (e) {
      print("Error signing in with Facebook: $e");
    }
  }
}

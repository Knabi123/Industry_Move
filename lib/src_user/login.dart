// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:company/src/bottombar.dart';
import 'package:company/src_user/register.dart';
// import 'package:newlogin/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width + 20,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/background-2.png'),
                              fit: BoxFit.fill)),
                    ),
                  )
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
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
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
                          )
                        ]),
                    child: Column(children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade200))),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username", //ข้อความในช่อง
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          obscuringCharacter: '*',
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password", //ข้อความในช่อง
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.black),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBar()));
                      },
                      child: Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(colors: [
                            Colors.purple,
                            Colors.indigo,
                          ]),
                          color: Colors.deepPurple,
                        ),
                        child: Center(
                          child: Text(
                            'Log in',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      //Text go next page
                      child: Text('Create Account'),
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => RegisterForm()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.all(5), //size เหงาของ icon
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white54),
                          child: Image.asset(
                            'assets/images/facebook.png',
                            height: 40,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white54),
                          child: Image.asset(
                            'assets/images/gmail.png',
                            height: 40,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white54),
                          child: Image.asset(
                            'assets/images/instagram.png',
                            height: 40,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

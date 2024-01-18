// ignore_for_file: prefer_const_constructors

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
    return Scaffold(
      backgroundColor: Colors.grey[300], //สีพื้นหลัง
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 25),
              Text(
                'Log in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius:
                        BorderRadius.circular(50), //รูปลักษณ์ช่องกรอกข้อมูล ID
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0), // ตำแหน่งข้อความ ID ในช่อง
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ID'), //ข้อความในช่อง
                    ),
                  ),
                ),
              ),

              //password textfield
              SizedBox(height: 20), //ระยะห่างระหว่าง ID กับ Pw
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius:
                        BorderRadius.circular(50), //รูปลักษณ์ช่องกรอกข้อมูล ID
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0), // ตำแหน่งข้อความ Password ในช่อง
                    child: TextField(
                      obscureText: true, //ปิดข้อความ pw
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password' //ข้อความในช่อง
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              //Login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: InkWell(
                  onTap: () {
                    // Navigate to another page (RegisterPage in this case)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomBar()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Sign up button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: InkWell(
                  onTap: () {
                    // Navigate to another page (RegisterPage in this case)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: const [
              //     SquareTile(
              //         imagePath: 'images/facebook.png'), //facebook button
              //     SizedBox(
              //       width: 60,
              //     ),
              //     SquareTile(imagePath: 'images/gmail.png') //gmail button
              //   ],
              // ),

              //not a member? register now
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

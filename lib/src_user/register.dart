// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:company/firestore_service.dart';
import 'package:company/src_user/login.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterForm();
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool isIdEmpty = false;
  bool isPasswordEmpty = false;
  bool isNameEmpty = false;
  bool isPhoneNumberEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 55, 0, 95),
              Color.fromARGB(255, 217, 184, 245)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80.0),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                        ),
                      );
                    },
                  ),
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              _buildTextField(idController, 'ID', Icons.person,
                  isEmpty: isIdEmpty),
              SizedBox(height: 20.0),
              _buildTextField(passwordController, 'Password', Icons.lock,
                  obscureText: true, isEmpty: isPasswordEmpty),
              SizedBox(height: 20.0),
              _buildTextField(nameController, 'Name', Icons.person_outline,
                  isEmpty: isNameEmpty),
              SizedBox(height: 20.0),
              _buildTextField(
                  phoneNumberController, 'Phone number', Icons.phone,
                  keyboardType: TextInputType.phone,
                  isEmpty: isPhoneNumberEmpty),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isIdEmpty = idController.text.isEmpty;
                    isPasswordEmpty = passwordController.text.isEmpty;
                    isNameEmpty = nameController.text.isEmpty;
                    isPhoneNumberEmpty = phoneNumberController.text.isEmpty;
                  });

                  if (!isIdEmpty &&
                      !isPasswordEmpty &&
                      !isNameEmpty &&
                      !isPhoneNumberEmpty) {
                    bool isIdDuplicate =
                        await FirestoreService.isIdExists(idController.text);

                    if (isIdDuplicate) {
                      // แจ้งเตือนถ้า ID ซ้ำ
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('ID is already taken. Please Try again'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      if (phoneNumberController.text.length != 10) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Phone number should not exceed 10 digits.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      if (passwordController.text.length < 8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Password should be at least 8 characters.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      await FirestoreService.addUser(
                        idController.text,
                        passwordController.text,
                        nameController.text,
                        phoneNumberController.text,
                        role: 'Customer',
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: const Color.fromARGB(255, 198, 124, 211),
                  padding: EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  minimumSize: Size(250, 60),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text,
      bool isEmpty = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15.0),
          border: isEmpty ? Border.all(color: Colors.red) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  isEmpty = value.isEmpty;
                });
              },
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: TextStyle(color: Colors.white),
                hintText: labelText,
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(icon, color: Colors.white),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              keyboardType: keyboardType,
              obscureText: obscureText,
            ),
            if (isEmpty)
              Text('Please enter $labelText',
                  style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}

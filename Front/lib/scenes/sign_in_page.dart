// ignore_for_file: use_build_context_synchronously

import 'package:bricoloni_v2/scenes/recycling_company_home_screen.dart';
import 'package:bricoloni_v2/scenes/signup_page.dart';
import 'package:bricoloni_v2/scenes/simple_user_home_screen.dart';
import 'package:bricoloni_v2/scenes/transporter_home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginFailed = false; // Track the login status

  Future<Map<String, String>> loginUser(String s1, String s2) async {
    String category = '';
    String id = '';
    String wasteType = '';
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.12:3000/auth/user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"email": s1, "password": s2}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        final token = body['token'];

        // Parse JWT to get category and _id
        Map<String, dynamic> payload = Jwt.parseJwt(token);
        category = body['category'];
        id = payload['id'];
        wasteType = body['diy_waste_type'] ?? '';

        if (kDebugMode) {
          print('User logged in: token=$token, category=$category, id=$id');
        }
      } else {
        if (kDebugMode) {
          print('Failed to log in user: ${response.statusCode}');
        }
        setState(() {
          _isLoginFailed = true; // Set the login failure status to true
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
      setState(() {
        _isLoginFailed = true; // Set the login failure status to true
      });
    }
    return {'category': category, 'id': id, 'wasteType': wasteType};
  }

  void _showLoginFailedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text('Email or password is incorrect'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToSignupPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text(
          'Sign In / Sign Up',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Brocolini',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController, // Use the email controller
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                hintText: "Enter Your Mail",
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightGreen,
                  ), // Set the color of the border when the field is focused
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ), // Set the color of the border when the field is not focused
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController, // Use the password controller
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                hintText: "Enter Your Password",
                hintStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoginFailed =
                      false; // Reset login failure status on button press
                });
                String email = _emailController.text;
                String password = _passwordController.text;
                // Use the email and password for backend processing
                Map<String, String> userData = await loginUser(email, password);
                String id = userData["id"] ?? "";
                String category = userData["category"] ?? "";
                String wasteType = userData["wasteType"] ?? "";
                print(category);
                switch (category) {
                  case "DIY workshop":
                    break;
                  case "Recycling center":
                    print(wasteType);
                    print(id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Recycling_Company_HomeScreen(
                            wasteType: wasteType, id: id),
                      ),
                    );
                    break;
                  case "Simple user":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Simple_User_HomeScreen(id: id),
                      ),
                    );
                    break;
                  case "Transporter":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Transporter_HomeScreen(id: id),
                      ),
                    );
                    break;
                  default:
                    _showLoginFailedDialog(); // Show the dialog for login failure
                }
              },
              child: const Text('Sign In'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                _navigateToSignupPage();
              },
              child: const Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

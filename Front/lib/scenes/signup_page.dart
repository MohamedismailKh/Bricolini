import 'dart:convert';

import 'package:bricoloni_v2/scenes/recycling_sign_up.dart';
import 'package:bricoloni_v2/scenes/simple_user_home_screen.dart';
import 'package:bricoloni_v2/scenes/transporter_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import 'diy_sign_up.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String _selectedCategory = 'Simple user';
  final List<String> _categories = [
    'Simple user',
    'DIY workshop',
    'Recycling center',
    'Transporter',
  ];
  Future<String> createSimpleUser(
      String s1, String s2, String s3, String s4, String s5) async {
    String id = '';
    try {
      final response = await http
          .post(Uri.parse('http://192.168.1.12:3000/auth/signup'), body: {
        "email": s1,
        "username": s2,
        "password": s3,
        "phoneNumber": s4,
        "category": s5,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        final token = body['token'];
        Map<String, dynamic> payload = Jwt.parseJwt(token);
        id = payload['id'];
        if (kDebugMode) {
          print('User created: ${response.body}');
        }
      } else {
        if (kDebugMode) {
          print('Failed to create user: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
    }
    return id;
  }

  void _submitForm() async {
    final String email = _emailController.text;
    final String fullName = _fullNameController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    final String phoneNumber = _phoneNumberController.text;
    final String category = _selectedCategory;
    // Check if the password and confirm password fields match
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Password Mismatch'),
            content: const Text('Please make sure the passwords match.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Stop the sign-up process if passwords don't match
    }

    // Reset the text fields
    _emailController.clear();
    _fullNameController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _phoneNumberController.clear();

    // Navigate to the corresponding page based on the selected category
    if (category == 'Simple user') {
      // ignore: use_build_context_synchronously
      String id = '';
      id = createSimpleUser(email, fullName, password, phoneNumber, category)
          as String;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Simple_User_HomeScreen(id: id)),
      );
    } else if (category == 'DIY workshop') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DIY_Sign_Up(
            email: email,
            fullName: fullName,
            password: password,
            phoneNumber: phoneNumber,
          ),
        ),
      );
    } else if (category == 'Recycling center') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Recycling_Sign_Up(
                  email: email,
                  fullName: fullName,
                  password: password,
                  phoneNumber: phoneNumber,
                )),
      );
    } else if (category == 'Transporter') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Transporter_Sign_Up(
                  email: email,
                  fullName: fullName,
                  password: password,
                  phoneNumber: phoneNumber,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171918),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171918),
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.lightGreen),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _phoneNumberController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                dropdownColor: Colors.black87,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: TextStyle(color: Colors.blue),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.black,
                ),
                // ignore: unrelated_type_equality_checks
                child:
                    // ignore: unrelated_type_equality_checks
                    Text(
                        _selectedCategory == 'Simple user' ? 'SignUp' : 'Next'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Go back',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

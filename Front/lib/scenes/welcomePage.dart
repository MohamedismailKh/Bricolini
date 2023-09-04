import 'dart:async';

import 'package:bricoloni_v2/scenes/sign_in_page.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/images/Logo_Arcturus.png'),
            const SizedBox(height: 30),
            const Text(
              'Welcome to',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'BriColini',
              style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen),
            ),
            // Space between "Welcome to" and the logo
            // Add your logo widget here, you can use Image.asset or any other widget
            // Example: Image.asset('assets/logo.png', width: 100, height: 100),
            const SizedBox(
                height: 120), // Space between the logo and the button
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: Container(
                width: 150, // Set the width of the button
                height: 40, // Set the height of the button
                decoration: BoxDecoration(
                  color: Colors.lightGreen, // Set the button background color
                  borderRadius:
                      BorderRadius.circular(30), // Set rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Identify',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer when the screen is loaded
    Timer(const Duration(seconds: 5), () {
      // After 5 seconds, navigate to the second screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            Image.asset(
              'lib/images/Logo_Arcturus.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 270),
            const Text(
              "@Arcturus",
              style: TextStyle(color: Colors.lightGreen),
            ), // Space between the logo and the button
          ],
        ),
      ),
    );
  }
}

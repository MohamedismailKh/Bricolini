import 'package:bricoloni_v2/scenes/transporter_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

class Transporter_Sign_Up extends StatefulWidget {
  final String email;
  final String fullName;
  final String password;
  final String phoneNumber;

  const Transporter_Sign_Up({
    Key? key,
    required this.email,
    required this.fullName,
    required this.password,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _Transporter_Sign_UpState createState() => _Transporter_Sign_UpState();
}

class _Transporter_Sign_UpState extends State<Transporter_Sign_Up> {
  final TextEditingController _regionController = TextEditingController();
  double _numTrucksType1 = 0.0;
  double _numTrucksType2 = 0.0;
  double _numTrucksType3 = 0.0;

  Future<String> createTransporter(String s1, String s2, String s3, String s4,
      String s5, String s6, String s7, String s8, String s9) async {
    String id = '';
    final response = await http
        .post(Uri.parse("http://192.168.1.12:3000/auth/signup"), body: {
      "email": s1,
      "username": s2,
      "password": s3,
      "phoneNumber": s4,
      "category": s5,
      "region": s6,
      "number_of_small_trucks": s7,
      "number_of_medium_trucks": s8,
      "number_of_big_trucks": s9,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final token = body['token'];
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      id = payload['id'];
    }
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Transporter',
          style: TextStyle(color: Colors.lightGreen),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            TextField(
              controller: _regionController,
              decoration: const InputDecoration(
                labelText: 'Address',
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
            Column(
              children: [
                Text(
                  'Number Of Small Trucks: ${_numTrucksType1.toInt()}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                SpinBox(
                  min: 0,
                  max: 100,
                  value: 0,
                  onChanged: (value) {
                    setState(() {
                      _numTrucksType1 = value;
                    });
                  },
                  textStyle: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    filled: false,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    suffixIcon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Text(
                  'Number Of Median Trucks: ${_numTrucksType2.toInt()}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                SpinBox(
                  min: 0,
                  max: 100,
                  value: 0,
                  onChanged: (value) {
                    setState(() {
                      _numTrucksType2 = value;
                    });
                  },
                  textStyle: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    filled: false,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    suffixIcon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Text(
                  'Number Of Big Trucks: ${_numTrucksType3.toInt()}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                SpinBox(
                  min: 0,
                  max: 100,
                  value: 0,
                  onChanged: (value) {
                    setState(() {
                      _numTrucksType3 = value;
                    });
                  },
                  textStyle: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    filled: false,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    suffixIcon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String region = _regionController.text;
                int numSmallTrucks = _numTrucksType1.toInt();
                int numMedianTrucks = _numTrucksType2.toInt();
                int numBigTrucks = _numTrucksType3.toInt();
                String id = await createTransporter(
                    widget.email,
                    widget.fullName,
                    widget.password,
                    widget.phoneNumber,
                    "Transporter",
                    region,
                    numSmallTrucks.toString(),
                    numMedianTrucks.toString(),
                    numBigTrucks.toString());
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Transporter_HomeScreen(id: id),
                  ),
                );
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

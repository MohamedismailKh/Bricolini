import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class DIY_Sign_Up extends StatefulWidget {
  final String email;
  final String fullName;
  final String password;
  final String phoneNumber;

  const DIY_Sign_Up({
    Key? key,
    required this.email,
    required this.fullName,
    required this.password,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DIY_Sign_UpState createState() => _DIY_Sign_UpState();
}

// ignore: camel_case_types
class _DIY_Sign_UpState extends State<DIY_Sign_Up> {
  final TextEditingController _addressController = TextEditingController();
  int? _selectedItemIndex; // Track the index of the selected item
  // ignore: non_constant_identifier_names
  String Type_Waste = "";
  Future<void> createDIY_Workshop(String s1, String s2, String s3, String s4,
      String s5, String s6, String s7) async {
    await http.post(Uri.parse("http://192.168.1.12:3000/auth/signup"), body: {
      "email": s1,
      "username": s2,
      "password": s3,
      "phoneNumber": s4,
      "category": s5,
      "address": s6,
      "diy_waste_type": s7,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171918),
      appBar: AppBar(
        title: const Text('DIY_Workshop'),
        backgroundColor: const Color(0xFF171918),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _addressController,
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
            ),
            const SizedBox(height: 16),
            const Text(
              'Garbage type',
              style: TextStyle(fontSize: 18, color: Colors.lightGreen),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String address = _addressController.text;
                List<bool> checklist = List<bool>.filled(4, false);
                if (_selectedItemIndex != null) {
                  checklist[_selectedItemIndex!] = true;
                }
                switch (_selectedItemIndex) {
                  case 0:
                    Type_Waste = "wood waste";
                    break;
                  case 1:
                    Type_Waste = "iron waste";
                    break;
                  case 2:
                    Type_Waste = "construction waste";
                    break;
                  case 3:
                    Type_Waste = "others";
                    break;
                }
                await createDIY_Workshop(
                    widget.email,
                    widget.fullName,
                    widget.password,
                    widget.phoneNumber,
                    "DIY workshop",
                    address,
                    Type_Waste);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.black,
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CheckboxListTile buildCheckboxListTile(int index, String title) {
    return CheckboxListTile(
      title: Text(title),
      value: _selectedItemIndex == index, // Check if the item is selected
      onChanged: (value) {
        setState(() {
          if (value!) {
            _selectedItemIndex = index; // Update the selected item index
          } else {
            _selectedItemIndex = null; // Deselect the item if unchecked
          }
        });
      },
      secondary: _selectedItemIndex == index
          ? const Icon(Icons.check, color: Colors.green)
          : null,
    );
  }
}

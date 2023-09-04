import 'package:flutter/material.dart';


class ImageVerificationPage extends StatefulWidget {
  const ImageVerificationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageVerificationPageState createState() => _ImageVerificationPageState();
}

class _ImageVerificationPageState extends State<ImageVerificationPage> {
  bool _isLoading = true; // To track if image verification is in progress

  @override
  void initState() {
    super.initState();
    // Simulate image verification delay, you should replace
    //this with actual verification logic
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Image Verification',
          style: TextStyle(color: Colors.lightGreen, fontSize: 20),
        ),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Show loading indicator while verifying
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your offer has been created successfully!',
                    style: TextStyle(color: Colors.lightGreen, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: const Text('Return To My Offers'),
                  ),
                ],
              ),
      ),
      backgroundColor: Colors.black,
    );
  }
}

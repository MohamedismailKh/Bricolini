import 'package:flutter/material.dart';

class MarketplaceVRPage extends StatelessWidget {
  const MarketplaceVRPage({Key? key}) : super(key: key);

  void onStartAR() {
    // Implement your functionality to start AR.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: onStartAR,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text('Start AR'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Place your device in the space where you want to start AR',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

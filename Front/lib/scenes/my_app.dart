import 'package:bricoloni_v2/scenes/welcomePage.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bricolini',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScreen(),
    );
  }
}

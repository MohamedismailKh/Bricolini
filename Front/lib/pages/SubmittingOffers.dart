import 'package:bricoloni_v2/pages/SimpleUserHistory.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

import 'SearchingTransporter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Submit your offer!',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Submit your offer!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _garbageType = "garbage type";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.pop(context); // Navigate back when the arrow is pressed
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Submit your offer!',
                  style: TextStyle(fontSize: 30),
                ),

                DropdownButton<String>(
                  value: _garbageType,
                  items: const [
                    DropdownMenuItem(
                        child: Text("garbage type"), value: "garbage type"),
                    DropdownMenuItem(child: Text("Metal"), value: "metal"),
                    DropdownMenuItem(child: Text("Wood"), value: "wood"),
                    DropdownMenuItem(
                        child: Text("Construction waste"),
                        value: "constructionWaste"),
                    DropdownMenuItem(child: Text("Other"), value: "other")
                  ],
                  onChanged: (value) {
                    setState(() {
                      _garbageType = value as String;
                    });
                  },
                ),
                SizedBox(height: 70), //saut de ligne
                Text(
                  'Choose garbage location',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(alignment: Alignment.center, child: Text("")),
          ),
          SizedBox(height: 10), //saut de ligne

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.lightGreen, // Set the background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 15.0), // Set the padding
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UploadImage(title: "Upload a photo of your garbage")),
                );
              },
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

//////////////deuxieme page/////////////
class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  String? _image;
  final picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile.path; //_image = File(pickedFile.path)
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _image != null
              ? Image.network(
                  //on peut travailler avec Image.file mais _image doit etre un File et pas String .
                  _image!,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.grey, // Set the background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 15.0), // Set the padding
              ),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              child: Text('Choose from Gallery'),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.grey, // Set the background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 15.0), // Set the padding
              ),
              onPressed: () {
                getImage(ImageSource.camera);
              },
              child: Text('Take a Photo'),
            ),
          ],
        ),
      ],
    );
  }
}

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Submit your Offer!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Upload a photo of your garbage!',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 10), //saut de ligne
                Text(
                  'Regulations require you to upload a photo of your garbage...',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 40),
                ImageUploadWidget(),
              ],
            ),
          ),

          SizedBox(height: 10), //saut de ligne

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.lightGreen, // Set the background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 15.0), // Set the padding
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SimpleUhistory()),
                );
              },
              child: const Text(
                'Verify',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

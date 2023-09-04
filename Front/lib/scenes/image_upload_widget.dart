import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ImageUploadWidget extends StatefulWidget {
  String? _image;

  ImageUploadWidget({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();

  String? getImagePath() {
    return _image;
  }
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

  String? getImagePath() {
    return _image;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _image != null
              ? Image.file(
                  // use Image.file to display image from a local path
                  File(_image!),
                  fit: BoxFit.cover,
                )
              : const Center(
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.lightGreen,
                  ),
                ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.0),
                ),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: const Text('Choose from Gallery'),
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.0),
                ),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: const Text('Take a Photo'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

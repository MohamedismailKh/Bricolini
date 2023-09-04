import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SimpleUhistory extends StatefulWidget {
  const SimpleUhistory({Key? key}) : super(key: key);

  @override
  _SimpleUhistoryState createState() => _SimpleUhistoryState();
}

class _SimpleUhistoryState extends State<SimpleUhistory> {
  List<Offer> history_list = [
    Offer(
        photo: "../../assets/Logo_Arcturus.png",
        title: "Ahmed",
        address: "Charguiya",
        price: 100,
        type: "Wood"),
    Offer(
        photo: "../../assets/Logo_Arcturus.png",
        title: "Hamiiid",
        address: "Tunis, Tunisie",
        price: 100,
        type: "Wood")
  ];
  void addToHistory(Offer offer) {
    history_list.add(offer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(color: Colors.lightGreen, fontSize: 20),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: history_list.length,
        itemBuilder: (context, index) {
          final offer = history_list[index];

          return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Choose the desired border color here.
                  width: 1.0, // Adjust the border width as needed.
                ),
                borderRadius: BorderRadius.circular(
                    8.0), // Adjust the border radius as needed.
              ),
              child: ListTile(
                leading: Image.network(
                  offer.photo,
                  width: 50,
                  height: 50,
                ),
                title: Text(offer.title),
                subtitle: Text(
                    '${offer.type} | ${offer.address}  | ${offer.price} \$'),
              ));
        },
      ),
    );
  }
}

class Offer {
  final String photo;
  final String title;
  final String address;
  final String type;
  final double price;

  Offer({
    required this.photo,
    required this.title,
    required this.address,
    required this.type,
    required this.price,
  });
}

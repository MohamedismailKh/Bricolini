import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Offer {
  final String photo;
  final String address;
  final String type;
  final int price;
  final bool selected;
  final double estimatedDistance;
  final String offerId;
  final String idTransporter;
  final String idOfferProvider;
  final String idRecyclingCenter;
  final bool confirmedByTransporter;

  Offer(
      {required this.selected,
      required this.photo,
      required this.address,
      required this.type,
      required this.estimatedDistance,
      required this.price,
      required this.offerId,
      required this.idTransporter,
      required this.idOfferProvider,
      required this.idRecyclingCenter,
      required this.confirmedByTransporter});
  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
        selected: json['selected'] ?? false,
        photo: json['img'],
        price: 300,
        address: json['location'],
        estimatedDistance: 0,
        type: json['waste_type'],
        offerId: json['_id'],
        idTransporter: json['id_transporter'] ?? "",
        idOfferProvider: json['id_offerProvider'] ?? "",
        idRecyclingCenter: json['id_recyclingCenter'] ?? "",
        confirmedByTransporter: json['confirmedByTransporter'] ?? true);
  }
}

class TransporterReceivedOffers extends StatefulWidget {
  final String id;
  const TransporterReceivedOffers({super.key, required this.id});

  @override
  State<TransporterReceivedOffers> createState() =>
      _Recycling_center_confirmed_offerState();
}

// ignore: camel_case_types
class _Recycling_center_confirmed_offerState
    extends State<TransporterReceivedOffers> {
  Future<List<Offer>> fetchAllOffers() async {
    final response = await http.get(
        Uri.parse('http://192.168.1.12:3000/transporters/offers/${widget.id}'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Offer> offers =
          jsonList.map((json) => Offer.fromJson(json)).toList();
      return offers;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load users');
    }
  }

  Future<void> updateOffer(String id) async {
    var url = Uri.parse(
        'http://192.168.1.12:3000/offer/$id'); // update with your endpoint url
    var response = await http.patch(url, body: {"confirmedByTransporter": "1"});

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (kDebugMode) {
        print('Offer updated successfully');
      }
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Offer Confirmed'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      print('Failed to update the offer');
    }
  }

  List<Offer> receivedOffers = [];
  @override
  void initState() {
    super.initState();
    fetchAllOffers().then((offers) {
      setState(() {
        receivedOffers.addAll(
            offers.where((offer) => offer.confirmedByTransporter == false));
      });
      print(receivedOffers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171918),
      body: ListView.builder(
        itemCount: receivedOffers.length,
        itemBuilder: (context, index) {
          final offer = receivedOffers[index];

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
              textColor: Colors.white10,
              leading: Image.asset(
                offer.photo,
                width: 50,
                height: 50,
              ),
              title: Text(offer.address),
              subtitle: Text(
                  '${offer.type} | ${offer.estimatedDistance} km | ${offer.price} \$'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen, // background color
                ),
                onPressed: () {
                  print(widget.id);
                  updateOffer(offer.offerId);
                },
                child: const Text('ConfirmOffer'),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:bricoloni_v2/scenes/booking_offer_page.dart';
import 'package:bricoloni_v2/scenes/paiement.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecyclingCompanyReceivedOffers extends StatefulWidget {
  final String id;
  final String wasteType;
  const RecyclingCompanyReceivedOffers(
      {Key? key, required this.wasteType, required this.id})
      : super(key: key);
  @override
  State<RecyclingCompanyReceivedOffers> createState() =>
      _RecyclingCompanyReceivedOffersState();
}

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
        confirmedByTransporter: json['confirmedByTransporter'] ?? false);
  }
}

class _RecyclingCompanyReceivedOffersState
    extends State<RecyclingCompanyReceivedOffers> {
  Future<List<Offer>> fetchAllOffers() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.12:3000/recycling-centre/offers'));

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

  List<Offer> receivedOffers = [];
  @override
  void initState() {
    super.initState();
    fetchAllOffers().then((offers) {
      setState(() {
        receivedOffers.addAll(offers.where((offer) =>
            offer.type == widget.wasteType && offer.selected == false));
      });
      print(receivedOffers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: receivedOffers.length,
        itemBuilder: (context, index) {
          final offer = receivedOffers[index];

          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.0), // Adjust the vertical distance as needed
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Add horizontal padding here
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  border: Border.all(
                    color: Colors.grey, // Choose the desired border color here.
                    width: 1.0, // Adjust the border width as needed.
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius as needed.
                ),
                child: ListTile(
                  textColor: Colors.white,
                  leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey
                            .shade600, // Choose the desired image border color here.
                        width: 1.0, // Adjust the image border width as needed.
                      ),
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the image border radius as needed.
                    ),
                    child: ClipRRect(
                      // Use ClipRRect to apply borderRadius to the image
                      borderRadius: BorderRadius.circular(
                          6.0), // Adjust the image border radius as needed.
                      child: Image.asset(
                        offer.photo,
                        width: 72,
                        height: 90,
                        fit: BoxFit
                            .cover, // Use BoxFit.cover to scale and maintain aspect ratio
                      ),
                    ),
                  ),
                  title: Text(offer.address),
                  subtitle: Text(
                    '${offer.type} | ${offer.estimatedDistance} km | ${offer.price} \$',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookingOfferPage(offer: offer, id: widget.id),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors
                          .lightGreen), // Change the background color here
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Change the text color here
                    ),
                    child: const Text('Book Offer'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ignore: camel_case_types
class Recycling_center_confirmed_offer extends StatefulWidget {
  final String id;
  const Recycling_center_confirmed_offer({super.key, required this.id});

  @override
  State<Recycling_center_confirmed_offer> createState() =>
      _Recycling_center_confirmed_offer();
}

// ignore: camel_case_types
class _Recycling_center_confirmed_offer
    extends State<Recycling_center_confirmed_offer> {
  Future<List<Offer>> fetchAllOffers() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.12:3000/recycling-centre/offers/pending/${widget.id}'));

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

  List<Offer> receivedOffers = [];
  @override
  void initState() {
    super.initState();
    fetchAllOffers().then((offers) {
      setState(() {
        receivedOffers.addAll(
            offers.where((offer) => offer.confirmedByTransporter == true));
      });
      print(receivedOffers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: receivedOffers.length,
        itemBuilder: (context, index) {
          final offer = receivedOffers[index];

          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.0), // Adjust the vertical distance as needed
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Add horizontal padding here
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  border: Border.all(
                    color: Colors.grey, // Choose the desired border color here.
                    width: 1.0, // Adjust the border width as needed.
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius as needed.
                ),
                child: ListTile(
                  textColor: Colors.white,
                  leading: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey
                            .shade600, // Choose the desired image border color here.
                        width: 1.0, // Adjust the image border width as needed.
                      ),
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the image border radius as needed.
                    ),
                    child: ClipRRect(
                      // Use ClipRRect to apply borderRadius to the image
                      borderRadius: BorderRadius.circular(
                          6.0), // Adjust the image border radius as needed.
                      child: Image.asset(
                        offer.photo,
                        width: 72,
                        height: 90,
                        fit: BoxFit
                            .cover, // Use BoxFit.cover to scale and maintain aspect ratio
                      ),
                    ),
                  ),
                  title: Text(offer.address),
                  subtitle: Text(
                    '${offer.type} | ${offer.estimatedDistance} km | ${offer.price} \$',
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Paiement(waste: offer.type, price: offer.price),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors
                          .lightGreen), // Change the background color here
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Change the text color here
                    ),
                    child: const Text('Pay'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

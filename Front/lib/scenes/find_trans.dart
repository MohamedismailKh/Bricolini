import 'package:bricoloni_v2/scenes/paiement.dart';
import 'package:bricoloni_v2/scenes/recycling_company_home_screen.dart';
import 'package:bricoloni_v2/scenes/recycling_company_received_offers.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FindTrans extends StatefulWidget {
  final String id;
  final Offer offer;
  final String location;
  final String waste;
  const FindTrans(
      {Key? key,
      required this.location,
      required this.offer,
      required this.id,
      required this.waste})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FindTransState createState() => _FindTransState();
}

class Transporter {
  final String tName;
  final String photo;
  final String location;
  final String vehicule;
  final double pricePerKm;
  final String idTransporter;

  Transporter(
      {required this.tName,
      required this.photo,
      required this.location,
      required this.vehicule,
      required this.pricePerKm,
      required this.idTransporter});

  factory Transporter.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("JSON data is null.");
    }

    // Perform null checks and handle missing keys appropriately
    if (json['username'] == null || json['region'] == null) {
      throw const FormatException("JSON data is missing required fields.");
    }

    return Transporter(
        tName: json['username'],
        photo: "lib/images/Logo_Arcturus.png",
        location: json['region'],
        vehicule: "Volvo",
        pricePerKm: 10,
        idTransporter: json["_id"] ?? "");
  }
}

class _FindTransState extends State<FindTrans> {
  List<Transporter> historyList = [];
  Future<void> updateOffer(String id, String s) async {
    var url = Uri.parse(
        'http://192.168.1.12:3000/offer/$id'); // update with your endpoint url
    var response = await http
        .patch(url, body: {"id_transporter": s, "confirmedByTransporter": "0"});

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Offer updated successfully');
    } else {
      print('Failed to update the offer');
    }
  }

  Future<List<Transporter>> fetchAllTransporters() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.12:3000/auth/usersbycategory/Transporter'),
    );

    if (response.statusCode == 200) {
      List<dynamic>? jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        List<Transporter> transporters = jsonResponse
            .map((dynamic item) => Transporter.fromJson(item))
            .toList();
        return transporters;
      } else {
        print('JSON response data is null or empty.');
        return []; // Return an empty list in case of null JSON data
      }
    } else {
      throw Exception('Failed to load transporters ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllTransporters().then((transporters) {
      setState(() {
        historyList.addAll(transporters.where(
            (transporter) => transporter.location == widget.offer.address));
      });
      print(historyList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text(
          'Find a transporter',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          final transporter = historyList[index];

          return Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white10,
              border: Border.all(
                color: Colors.white10,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius:
                        25, // Adjust the radius to control the size of the circular image
                    backgroundImage: AssetImage(transporter.photo),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transporter.tName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${transporter.vehicule} | ${transporter.location} | ${transporter.pricePerKm}\$ PerKM',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Recycling_Company_HomeScreen(
                            wasteType: widget.waste,
                            id: widget.id,
                          ),
                        ),
                      );
                      updateOffer(
                          widget.offer.offerId, transporter.idTransporter);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.lightGreen, // Change the background color here
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Select'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:bricoloni_v2/scenes/find_trans.dart';
import 'package:bricoloni_v2/scenes/recycling_company_received_offers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BookingOfferPage extends StatefulWidget {
  final Offer offer;
  final String id;
  const BookingOfferPage({Key? key, required this.offer, required this.id})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookingOfferPageState createState() => _BookingOfferPageState();
}

class _BookingOfferPageState extends State<BookingOfferPage> {
  Future<void> updateOffer(String id, String s) async {
    var url = Uri.parse(
        'http://192.168.1.16:3000/offer/$id'); // update with your endpoint url
    var response =
        await http.patch(url, body: {"id_recyclingCenter": s, "selected": "1"});

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Offer updated successfully');
    } else {
      print(response.statusCode);
      print('Failed to update the offer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Booking Offer'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.offer.photo,
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            Text(
              'Address: ${widget.offer.address}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Type: ${widget.offer.type}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Estimated Distance: ${widget.offer.estimatedDistance} km',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Demanded Price: ${widget.offer.price} \$',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FindTrans(
                      location: widget.offer.address,
                      offer: widget.offer,
                      id: widget.id,
                      waste: widget.offer.type,
                    ),
                  ),
                );
                updateOffer(widget.offer.offerId, widget.id);
              },
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.lightGreen, // Set the desired background color here
              ),
              child: const Text('Select Transporter'),
            )
          ],
        ),
      ),
    );
  }
}

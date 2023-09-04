import 'package:flutter/material.dart';

class FindTrans extends StatefulWidget {
  const FindTrans({Key? key}) : super(key: key);

  @override
  _FindTransState createState() => _FindTransState();
}

class _FindTransState extends State<FindTrans> {
  List<Transporter> historyList = [
    Transporter(
      photo: "../../assets/Logo_Arcturus.png",
      tName: "Ahmed",
      location: "Casablanca",
      pricePerKm: 100,
      vehicule: "camion blabla",
    ),
    Transporter(
      photo: "../../assets/Logo_Arcturus.png",
      tName: "Hamiiid",
      location: "Tunis, Tunisie",
      pricePerKm: 100,
      vehicule: "camion blabla",
    ),
  ];

  void addToHistory(Transporter transporter) {
    setState(() {
      historyList.add(transporter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find a transporter',
          style: TextStyle(color: Colors.lightGreen, fontSize: 20),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          final offer = historyList[index];

          return Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.network(
                    offer.photo,
                    width: 50,
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.tName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${offer.vehicule}',
                      ),
                      Text(
                        '${offer.location}',
                      ),
                      Text(
                        '${offer.pricePerKm} \$',
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement button functionality
                    },
                    child: Text('Button'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
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

class Transporter {
  final String tName;
  final String photo;
  final String location;
  final String vehicule;
  final double pricePerKm;

  Transporter({
    required this.tName,
    required this.photo,
    required this.location,
    required this.vehicule,
    required this.pricePerKm,
  });
}
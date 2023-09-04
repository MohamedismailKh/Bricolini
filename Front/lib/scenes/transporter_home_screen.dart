import 'package:bricoloni_v2/scenes/about-us.dart';
import 'package:bricoloni_v2/scenes/home_page.dart';
import 'package:bricoloni_v2/scenes/VR.dart';
import 'package:bricoloni_v2/scenes/marketplace.dart';
import 'package:bricoloni_v2/scenes/profile.dart';
import 'package:bricoloni_v2/scenes/stats_page.dart';
import 'package:bricoloni_v2/scenes/transporter_received_offers.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Transporter_HomeScreen extends StatefulWidget {
  final String id;
  const Transporter_HomeScreen({Key? key, required this.id}) : super(key: key);

  @override
  Transporter_HomeScreenState createState() => Transporter_HomeScreenState();
}

// ignore: camel_case_types
class Transporter_HomeScreenState extends State<Transporter_HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> get _pages => [
        const HomePage(),
        MarketPlace(),
        const StatsPage(),
        TransporterReceivedOffers(id: widget.id),
      ];

  void _goToAboutUsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => About_Us()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Transporter Home Screen',
            style: TextStyle(color: Colors.white)),
        actions: [
          GestureDetector(
            onTap: _goToAboutUsPage,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('lib/images/Logo_Arcturus.png',
                  width: 40, height: 40),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black87, // Set the desired background color here
        ),
        child: BottomNavigationBar(
          // backgroundColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedItemColor:
              Colors.lightGreen, // Change this to your desired color
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Marketplace',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.stacked_line_chart),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_task),
              label: 'Received Offers',
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bricoloni_v2/scenes/about-us.dart';
import 'package:bricoloni_v2/scenes/home_page.dart';
import 'package:bricoloni_v2/scenes/VR.dart';
import 'package:bricoloni_v2/scenes/marketplace.dart';
import 'package:bricoloni_v2/scenes/profile.dart';
import 'package:bricoloni_v2/scenes/recycling_company_received_offers.dart';
import 'package:bricoloni_v2/scenes/stats_page.dart';
import 'package:flutter/material.dart';

class Recycling_Company_HomeScreen extends StatefulWidget {
  final String wasteType;
  final String id;
  final String? badge;
  const Recycling_Company_HomeScreen({
    Key? key,
    required this.wasteType,
    required this.id,
    this.badge,
  }) : super(key: key);

  @override
  _Recycling_Company_HomeScreenState createState() =>
      _Recycling_Company_HomeScreenState();
}

class _Recycling_Company_HomeScreenState
    extends State<Recycling_Company_HomeScreen> {
  int _selectedIndex = 0;

  void _goToAboutUsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => About_Us()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _pages = [
      const HomePage(),
      MarketPlace(),
      const StatsPage(),
      RecyclingCompanyReceivedOffers(
        wasteType: widget.wasteType,
        id: widget.id,
      ),
      Recycling_center_confirmed_offer(id: widget.id),
      Profile(title: "title", badge: widget.badge)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Recycling Company HomeScreen'),
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
              icon: Icon(Icons.call_received),
              label: 'Received Offers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.offline_pin_rounded),
              label: 'Confirmed Offers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}

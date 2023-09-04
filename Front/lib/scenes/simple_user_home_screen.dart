import 'package:bricoloni_v2/scenes/about-us.dart';
import 'package:bricoloni_v2/scenes/home_page.dart';
import 'package:bricoloni_v2/scenes/VR.dart';
import 'package:bricoloni_v2/scenes/marketplace.dart';
import 'package:bricoloni_v2/scenes/simple_user_offers.dart';
import 'package:bricoloni_v2/scenes/stats_page.dart';
import 'package:flutter/material.dart';

class Simple_User_HomeScreen extends StatefulWidget {
  final String id;
  const Simple_User_HomeScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _Simple_User_HomeScreenState createState() => _Simple_User_HomeScreenState();
}

class _Simple_User_HomeScreenState extends State<Simple_User_HomeScreen> {
  int _selectedIndex = 0;

  final List<IconData> _iconList = [
    Icons.home,
    Icons.shopping_cart,
    Icons.stacked_line_chart,
    Icons.add_task,
  ];

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
      SimpleUserOffers(id: widget.id),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Simple User HomeScreen'),
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
              label: 'Offers',
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bricoloni_v2/scenes/about-us.dart';
import 'package:bricoloni_v2/scenes/history_page.dart';
import 'package:bricoloni_v2/scenes/home_page.dart';
import 'package:bricoloni_v2/scenes/VR.dart';
import 'package:bricoloni_v2/scenes/stats_page.dart';
import 'package:bricoloni_v2/scenes/paiement.dart';
import 'package:bricoloni_v2/scenes/sign_in_page.dart';
import 'package:bricoloni_v2/scenes/stats_page.dart';
import 'package:bricoloni_v2/scenes/about-us.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isRailVisible = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isRailVisible = false;
    });
  }

  void _onBackPressed() {
    setState(() {
      _isRailVisible = true;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const HistoryPage(),
    const MarketplaceVRPage(),
    const StatsPage(),
    const SignInPage(),
  ];

  final List<IconData> _iconList = [
    Icons.home,
    Icons.history,
    Icons.shopping_cart,
    Icons.stacked_line_chart,
    Icons.person,
  ];
  void _goToAboutUsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => About_Us()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackPressed();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF171918), // Add this line
        appBar: AppBar(
          title: const Text(
            'Bricolini',
            style: TextStyle(color: Colors.lightGreen),
          ),
          backgroundColor: const Color(0xFF171918),
          actions: [
            GestureDetector(
              onTap: _goToAboutUsPage,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.asset('lib/images/Logo_Arcturus.png',
                    width: 40, height: 40),
              ),
            ),
          ],
        ),
        body: Row(
          children: [
            if (_isRailVisible)
              Container(
                width: 92,
                height: double.infinity,
                color: const Color(0xFF171918),
                child: ListView.builder(
                  itemCount: _iconList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onItemTapped(index),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          _iconList[index],
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: _pages[_selectedIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

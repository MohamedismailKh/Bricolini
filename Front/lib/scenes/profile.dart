import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bricoloni_v2/scenes/welcomePage.dart';

class Profile extends StatefulWidget {
  final String title;
  final String? badge;
  const Profile({Key? key, required this.title, this.badge}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black,
              Colors.grey[850]!,
            ], begin: Alignment.topCenter, end: Alignment.center),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: height / 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              const AssetImage('lib/images/Logo_Arcturus.png'),
                          radius: height / 10,
                        ),
                        SizedBox(
                          height: height / 15, // Increased space here
                        ),
                        const Text(
                          'Recycling Company',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.lightGreenAccent,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height / 2.2),
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height / 2.6, left: width / 20, right: width / 20),
                  child: Column(
                    children: <Widget>[
                      Card(
                        color: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(width / 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              headerChild(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 20),
                        child: Column(
                          children: <Widget>[
                            infoCard(width, Icons.email,
                                'recyclingcompany@gmail.com'),
                            infoCard(width, Icons.call, '+12-1234567890'),
                            Padding(
                              padding: EdgeInsets.only(top: height / 30),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Perform logout here
                                  _logout(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(height / 40),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 24.0),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget headerChild() => Expanded(
        child: AnimatedContainer(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: Container(
            width: 50.0, // Set the width you want
            height: 50.0, // Set the height you want
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/bronzeAsset 2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
  Widget infoCard(double width, IconData icon, String data) {
    return Card(
      color: Colors.grey[800],
      margin: const EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.lightGreen,
          size: 30,
        ),
        title: Text(
          data,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        onTap: () {
          if (kDebugMode) {
            print('$data selected');
          }
        },
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirstScreen()),
    );
  }
}

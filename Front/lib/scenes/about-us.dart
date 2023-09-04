import 'package:flutter/material.dart';

class About_Us extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primaryColor: Colors.black,
      hintColor: Colors.grey,
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.lightGreen, fontSize: 14),
        headline1: TextStyle(color: Colors.lightGreen, fontSize: 24),
        headline2: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: theme.primaryColor,
            leadingWidth: 100,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DetailScreen();
                    }));
                  },
                  child: Hero(
                    tag: 'logoHero',
                    child: Image.asset(
                      'lib/images/Logo_Arcturus.png',
                      width: 45,
                      height: 45,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Bricolini',
                  style: theme.textTheme.headline1,
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildRoundedContainer(
                'Bricolini - Revolutionizing Construction Waste Management',
                24,
                theme.textTheme.headline1!.color,
              ),
              const SizedBox(height: 16.0),
              _buildRoundedContainer(
                'At Bricolini, we are passionate about sustainability and committed to transforming the way construction waste is handled. We specialize in collecting construction garbage from building sites and facilitating its efficient recycling and repurposing...',
                14,
                theme.textTheme.bodyText1!.color,
              ),
              const SizedBox(height: 16.0),
              _buildRoundedContainer(
                'Join us at Bricolini as we lead the way in revolutionizing construction waste management. Together, we can create a greener, more sustainable future while unlocking the hidden value in discarded construction materials...',
                14,
                theme.textTheme.bodyText1!.color,
              ),
              const SizedBox(height: 32.0),
              Text(
                'Statistics',
                style: theme.textTheme.headline2,
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatisticCard(
                      '+30 000', 'cubic meters of landfill space'),
                  _buildStatisticCard(
                      '85%', 'recycling rate for construction waste'),
                  _buildStatisticCard('1M \$', 'Revenue'),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: theme.primaryColor,
      ),
    );
  }

  Widget _buildRoundedContainer(String text, double fontSize, Color? color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Set the border color here
          width: 2, // Set the border width here
        ),
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: color),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildStatisticCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Set the border color here
          width: 2, // Set the border width here
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 2.0),
          Text(
            value,
            style: const TextStyle(fontSize: 10, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'logoHero',
            child: Image.asset(
              'lib/images/Logo_Arcturus.png',
              width: 300.0,
            ),
          ),
        ),
      ),
    );
  }
}

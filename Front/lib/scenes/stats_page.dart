import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final List<double> transactionData = [
    1000,
    2000,
    1500,
    3000,
    2200,
    1700,
    2500,
  ];

  final List<double> garbageData = [
    25,
    35,
    20,
    20,
  ];

  final List<String> garbageCategories = [
    'Wood',
    'Iron',
    'Construction',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[850], // Add this line to set the background color
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Text(
            "Daily Transactions",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors
                    .white), // Change the text color to white to make it visible
          ),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 6,
                minY: 1000,
                maxY: 3000,
                lineTouchData: const LineTouchData(enabled: false),
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: transactionData.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value);
                    }).toList(),
                    isCurved: true,
                    color: Colors.green[300],
                    barWidth: 3,
                    belowBarData: BarAreaData(show: true),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Garbage Categories",
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Colors
                    .white), // Change the text color to white to make it visible
          ),
          Container(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: garbageData.asMap().entries.map((e) {
                  return PieChartSectionData(
                    color:
                        Color.lerp(Colors.green, Colors.black, e.value / 100),
                    value: e.value,
                    title: garbageCategories[e.key],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

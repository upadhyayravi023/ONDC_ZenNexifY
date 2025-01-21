import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';  // Import the fl_chart package

class CustomBarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Set the bar chart size dynamically (e.g., 50% of the screen width)
    double barChartSize = screenWidth * 0.4;

    List<BarChartGroupData> barChartData = [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(fromY: 30, color: Colors.lime, width: 20,toY: 5),
      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(fromY: 65, color: Colors.blue, width: 20, toY: 4),
      ]),
    ];

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Row for BarChart and TOTAL text
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: barChartSize,
                    height: barChartSize,
                    child: BarChart(
                      BarChartData(
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        barGroups: barChartData,
                      ),
                    ),
                  ),
                  // The column containing TOTAL text and the legends
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    width: screenWidth * 0.4, // Adjust the width accordingly
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TOTAL text aligned to the left
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "TOTAL 95",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 16),
                          // Custom Legend for "TO BE SHIPPED" and "TO BE DELIVERED"
                          LegendIndicator(
                            color: Colors.lime,
                            text: "TO BE SHIPPED",
                          ),
                          SizedBox(height: 8),
                          LegendIndicator(
                            color: Colors.blue,
                            text: "TO BE DELIVERED",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LegendIndicator extends StatelessWidget {
  final Color color;
  final String text;

  const LegendIndicator({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

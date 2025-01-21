
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Set the pie chart size dynamically (e.g., 50% of the screen width)
    double pieChartSize = screenWidth * 0.4;

    Map<String, double> dataMap = {
      "TO BE SHIPPED": 30,
      "TO BE DELIVERED": 65,
    };

    List<Color> colorList = [
      Colors.lime,
      Colors.blue,
    ];

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Row for PieChart and TOTAL text
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: pieChartSize,
                    height: pieChartSize,
                    child: PieChart(
                      dataMap: dataMap,
                      animationDuration: Duration(milliseconds: 800),
                      chartType: ChartType.disc,
                      colorList: colorList,
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true,
                        showChartValues: true,
                        showChartValuesOutside: false,
                        decimalPlaces: 0,
                      ),
                      legendOptions: LegendOptions(
                        showLegends: false, // Hide default legend
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
                          // TOTAL text aligned to the right
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "TOTAL 50",
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


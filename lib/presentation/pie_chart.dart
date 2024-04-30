import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const PieChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final Map<String, int> anomalyCounts = {};
    widget.data.forEach((item) {
      final String anomaly = item['anomaly'];
      if (anomalyCounts.containsKey(anomaly)) {
        anomalyCounts[anomaly] = anomalyCounts[anomaly]! + 1;
      } else {
        anomalyCounts[anomaly] = 1;
      }
    });

    final int totalAnomalies = anomalyCounts.values.reduce((a, b) => a + b);
    final List<PieChartSectionData> sections =
        anomalyCounts.entries.map((entry) {
      final double percentage = (entry.value / totalAnomalies) * 100;
      final int index = anomalyCounts.keys.toList().indexOf(entry.key);
      final Color color =
          getColorForIndex(index); // Function to get color based on index
      final double radius =
          touchedIndex == index ? 70 : 60; // Raise the touched section

      // Determine the title based on whether the section is touched
      final String title = touchedIndex == index
          ? '${percentage.toStringAsFixed(1)}%' // Show percentage if touched
          : entry.key; // Show name otherwise

      return PieChartSectionData(
        color: color,
        value: percentage,
        title: title,
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
    //const SizedBox(height: 30);
    return Column(
      children: <Widget>[
        const Text(
          'Anomaly Analysis (Pie Chart)',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        //const SizedBox(height: 20), // Adjust the height as needed
        const SizedBox(height: 100),
        Container(
          height: 200, // Increase the height to increase the radius
          width: 200, // Specify the height you want for the pie chart
          child: PieChart(
            PieChartData(
              //radius: 150,
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              startDegreeOffset: 180,
              borderData: FlBorderData(show: false),
              sectionsSpace: 5,
              centerSpaceRadius: 40,
              sections: sections,
            ),
          ),
        ),
      ],
    );
  }

  Color getColorForIndex(int index) {
    // Define a list of colors
    final List<Color> colors = [
      const Color.fromARGB(192, 225, 141, 225),
      const Color.fromARGB(182, 160, 66, 211),
      const Color.fromARGB(164, 232, 235, 76),
      const Color.fromARGB(163, 68, 192, 233),
      const Color.fromARGB(160, 59, 225, 64),
      // Add more colors as needed
    ];

    // Return a color based on the index, looping back to the start if necessary
    return colors[index % colors.length];
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  const BarChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
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

    final List<BarChartGroupData> barGroups =
        anomalyCounts.entries.map((entry) {
      return BarChartGroupData(
        x: anomalyCounts.keys.toList().indexOf(entry.key),
        barRods: [
          BarChartRodData(
            toY: entry.value
                .toDouble(), // Ensure this value is not zero or too small
            color: Color.fromARGB(255, 149, 26,
                210), // Ensure the color contrasts with the background
            width: 25, // Increase the width of the bars
          ),
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();

    return Padding(
      padding:
          const EdgeInsets.only(top: 40.0), // Adjust the top padding as needed
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          titlesData: const FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, 
                  getTitlesWidget: getBottomTitles),
            ),
          ),
            maxY:15, // Adjust this value based on your data
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        checkToShowHorizontalLine: (value) {
          return value % 10 == 0; // Show horizontal line every 10 units
        },
      ),
    ),
        swapAnimationDuration: const Duration(milliseconds: 10000), // Optional
        swapAnimationCurve: Curves.linear, // Optional
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontSize: 11,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Abuse', style: style);
      break;
    case 1:
      text = const Text('Assault', style: style);
      break;
    case 2:
      text = const Text('Fighting', style: style);
      break;
    case 3:
      text = const Text('Robbery', style: style);
      break;
    case 4:
      text = const Text('Arrest', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}

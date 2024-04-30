import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnomalyBarChart extends StatefulWidget {
  final List<Map<String, dynamic>> anomalies;

  const AnomalyBarChart({Key? key, required this.anomalies}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AnomalyBarChartState();
}

class AnomalyBarChartState extends State<AnomalyBarChart> {
  final Duration animDuration = const Duration(milliseconds: 500);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Anomaly Counts',
                  style: TextStyle(
                    color: Color.fromARGB(255, 253, 255, 254),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Monthly Anomaly Counts',
                  style: TextStyle(
                    color: Color.fromARGB(255, 254, 255, 254),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 38,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      isPlaying ? randomData() : mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      maxY: 10, // Adjust this value based on your data
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              'Month: ${group.x}\nValue: ${rod.toY.toStringAsFixed(2)}',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Month: ${group.x}\n',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: 'Value: ${rod.toY.toStringAsFixed(2)}\n',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchExtraThreshold: EdgeInsets.all(10),
        touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
          if (response == null || response.spot == null) {
            // Hide the tooltip when the user touches outside of a bar
            setState(() {
              touchedIndex = -1; // Assuming -1 means no bar is touched
            });
            return;
          }
          // Show the tooltip when a bar is touched
          setState(() {
            touchedIndex = response.spot!.touchedBarGroupIndex;
          });
        },
      ),
      barGroups: List.generate(widget.anomalies.length, (index) {
        // Assuming you have a way to map index to month name and data
        String monthName = widget.anomalies[index]
            ['month']; // Adjust this based on your data structure
        double value = widget.anomalies[index]['value']
            .toDouble(); // Adjust this based on your data structure
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value,
              color: Color.fromARGB(255, 113, 19, 128),
              width: 15,
            ),
          ],
          showingTooltipIndicators: touchedIndex == index
              ? [0]
              : [], // Only show tooltip for the touched bar
        );
      }),
    );
  }

  BarChartData randomData() {
    final random = Random();
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              'Month: ${group.x}\nValue: ${rod.toY.toStringAsFixed(2)}',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Month: ${group.x}\n',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        // Uncomment and adjust the touchCallback if needed
        // touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
        //   if (response == null || response.spot == null) {
        //     // Hide the tooltip when the user touches outside of a bar
        //     setState(() {
        //       touchedIndex = -1; // Assuming -1 means no bar is touched
        //     });
        //     return;
        //   }
        //   // Show the tooltip when a bar is touched
        //   setState(() {
        //     touchedIndex = response.spot!.touchedBarGroupIndex;
        //   });
        // },
      ),
      barGroups: List.generate(12, (index) {
        int value = random.nextInt(5) *
            10; // Adjust the multiplier based on your maxY value
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value.toDouble(),
              color: Color.fromARGB(139, 203, 111, 177),
              width: 15,
            ),
          ],
        );
      }),
    );
  }
}

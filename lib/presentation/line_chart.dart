import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final VoidCallback incrementRandomAnomaly;

  const LineChartWidget({
    Key? key,
    required this.data,
    required this.incrementRandomAnomaly,
  }) : super(key: key);

  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Anomaly Comparison Between Years',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: SfCartesianChart(
            primaryXAxis: const DateTimeAxis(
              labelStyle: TextStyle(color: Colors.white), // Set X-axis label color to white
            ),
            primaryYAxis: const NumericAxis(
              labelStyle: TextStyle(color: Colors.white), // Set Y-axis label color to white
            ),
            legend: const Legend(
              isVisible: true, // Enable legend
              textStyle: TextStyle(color: Colors.white), // Set legend text color to white
            ),
            series: _buildLineSeries(),
          ),
        ),
      ],
    );
  }

  List<LineSeries<Map<String, dynamic>, DateTime>> _buildLineSeries() {
    List<LineSeries<Map<String, dynamic>, DateTime>> seriesList = [];

    // Iterate through each anomaly type
    List anomalyTypes = widget.data.map((e) => e['anomaly']).toSet().toList();
    for (String anomalyType in anomalyTypes) {
      List<Map<String, dynamic>> anomalyData = widget.data.where((e) => e['anomaly'] == anomalyType).toList();

      // Generate a unique color for each anomaly type
      Color lineColor = Color((anomalyType.hashCode & 0xFFFFFF).toUnsigned(32) | 0xFF000000);

      // Create a LineSeries for each anomaly type
      seriesList.add(
        LineSeries<Map<String, dynamic>, DateTime>(
          dataSource: anomalyData,
          xValueMapper: (Map<String, dynamic> anomaly, _) =>
              DateTime(anomaly['year'], anomaly['month'], anomaly['day']),
          yValueMapper: (Map<String, dynamic> anomaly, _) => widget.data.indexOf(anomaly).toDouble(),
          name: anomalyType,
          color: lineColor,
        ),
      );
    }

    return seriesList;
  }

  @override
  void initState() {
    super.initState();
    widget.incrementRandomAnomaly();
  }
}

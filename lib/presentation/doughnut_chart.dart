import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChart extends StatefulWidget {
 @override
 _DoughnutChartState createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
 Map<String, int> anomalyCounts = {};

 @override
 void initState() {
    super.initState();
    loadData();
 }

 Future<void> loadData() async {
    String jsonString = await rootBundle.loadString('assets/anomalies.json');
    List<dynamic> jsonData = jsonDecode(jsonString);
    jsonData.forEach((item) {
      String anomaly = item['anomaly'];
      if (anomalyCounts.containsKey(anomaly)) {
        anomalyCounts[anomaly] = anomalyCounts[anomaly]! + 1;
      } else {
        anomalyCounts[anomaly] = 1;
      }
    });
    setState(() {});
 }

 @override
 Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        SizedBox(
          height: 400,
          child: SfCircularChart(
            title: ChartTitle(text: 'Anomaly Analysis (Doughnut Chart)', textStyle: TextStyle(color: Colors.white)),
            legend: const Legend(
              isVisible: true, // Enable the legend
              textStyle: TextStyle(color: Colors.white), // Set legend text color to white
            ), // Enable the legend
            series: <CircularSeries>[
              DoughnutSeries<Map<String, dynamic>, String>(
                dataSource: anomalyCounts.entries.map((entry) => {'anomaly': entry.key, 'count': entry.value}).toList(),
                xValueMapper: (Map<String, dynamic> data, _) => data['anomaly'],
                yValueMapper: (Map<String, dynamic> data, _) => data['count'],
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
 }
}

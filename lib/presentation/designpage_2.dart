import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_clsf/presentation/anomaly_barchart.dart';
import 'package:image_clsf/presentation/bar_chart.dart';
import 'package:image_clsf/presentation/pie_chart.dart';
import 'package:image_clsf/presentation/doughnut_chart.dart';
import 'package:image_clsf/presentation/line_chart.dart';

class DataVisualisation extends StatefulWidget {
  @override
  _DataVisualisationState createState() => _DataVisualisationState();
}

class _DataVisualisationState extends State<DataVisualisation> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    loadData().then((data) {
      setState(() {
        this.data = data; // Assuming 'data' is a class member to store the loaded data
      });
    });
  }

  Future<List<Map<String, dynamic>>> loadData() async {
    String jsonString = await rootBundle.loadString('assets/anomalies.json');
    List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Data Visualisation'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Bar Chart'),
              Tab(text: 'Pie Chart'),
              Tab(text: 'Doughnut Chart'),
              Tab(text: 'Anomaly Bar Chart'),
              Tab(text: 'Line Chart'),
            ],
          ),
          
        ),
        body: TabBarView(
          children: [
            BarChartWidget(data: data,),
            PieChartWidget(data: data),
            DoughnutChart(),
            const AnomalyBarChart(anomalies: [],),
           LineChartWidget(data: data, incrementRandomAnomaly: () {  },),
          ],
        ),
      ),
    );
  }
}






 
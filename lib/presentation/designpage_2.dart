import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_clsf/core/app_export.dart';
import 'package:image_clsf/core/utils/size_utils.dart';
import 'package:image_clsf/theme/theme_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataVisulaization extends StatefulWidget {
  DataVisulaization({Key? key}) : super(key: key);

  @override
  _DataVisulaizationState createState() => _DataVisulaizationState();
}

var rng = new Random();
var y = rng.nextInt(70) + 10;

class _DataVisulaizationState extends State<DataVisulaization> {
  late List<Map<String, dynamic>> chartData;


 @override
 void initState() {
    super.initState();
    loadChartData();
 }

  int min = 7319;
  int max = 7325;
  int randomNumber = 1;
  List<_CrimData> data = [

    _CrimData('ALAPUZHA', y),
    _CrimData('KOLLAM', 2850),
    _CrimData('ERNAKULAM', 14843),
    _CrimData('IDUKKI', 5421),
    _CrimData('KANNUR', 5888),
    _CrimData('KASARGOD', 3116)
  ];
 
 Future<void> loadChartData() async {
    String jsonString = await rootBundle.loadString('assets/CrimesData.json');

    List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      chartData = jsonResponse.cast<Map<String, dynamic>>();
      print(chartData.first.values.last);
      var value = chartData.first.values.last+1;
      print("$value");

      Random random = new Random();
      //int randomNumber = random.nextInt(100);
      int randomNumber = random.nextInt(5) + 80;
      print('$randomNumber');

    });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crime Data Visualization'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Total Anomalies detected',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 450,
              child: SfCartesianChart(
                //title: ChartTitle(text: 'Total IPC Crimes for Districts in 2001'),
                legend: const Legend(
                  isVisible: true,
                  textStyle: TextStyle(color: Colors.white), // Set legend item text color to white
                 ),
                primaryXAxis: const CategoryAxis(
                  labelStyle: TextStyle(color: Colors.white), // Set x-axis label color to white
                 ),
                primaryYAxis: const NumericAxis(
                  labelStyle: TextStyle(color: Colors.white), // Set y-axis label color to white
                 ),
                series: [
                  //ColumnSeries<Map<String, dynamic>, String>(
                  ColumnSeries<_CrimData, String>(

                    //dataSource: chartData,
                    dataSource: data,
                    xValueMapper: (_CrimData crime, _) => crime.year,
                    yValueMapper: (_CrimData crime, _) => crime.crimes,

                    //xValueMapper: (Map<String, dynamic> data, _) => data['DISTRICT'] as String,
                    //yValueMapper: (Map<String, dynamic> data, _) => data['TOTAL IPC CRIMES']+1 as int,
                    name: 'Total Anomaly',

                  ),
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    y = Random().nextInt(max - min) + min;
                    y = y+1;
                    print('$y');
                  });
                  print('button clicked');

                },
                child: Text('Refresh'),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 400,
              child: SfCircularChart(
                title: ChartTitle(text: 'Crime Analysis (Pie Chart)',  textStyle: TextStyle(color: Colors.white)),
                series: <CircularSeries>[
                  PieSeries<Map<String, dynamic>, String>(
                    dataSource: chartData,
                    xValueMapper: (Map<String, dynamic> data, _) => 'Murder',
                    yValueMapper: (Map<String, dynamic> data, _) => data['MURDER'] as int,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                  PieSeries<Map<String, dynamic>, String>(
                    dataSource: chartData,
                    xValueMapper: (Map<String, dynamic> data, _) => 'Rape',
                    yValueMapper: (Map<String, dynamic> data, _) => data['RAPE'] as int,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 400,
              child: SfCircularChart(
                title: ChartTitle(text: 'Crime Analysis (Doughnut Chart)', textStyle: TextStyle(color: Colors.white)),
                series: <CircularSeries>[
                  DoughnutSeries<Map<String, dynamic>, String>(
                    dataSource: chartData,
                    xValueMapper: (Map<String, dynamic> data, _) => 'Murder',
                    yValueMapper: (Map<String, dynamic> data, _) => data['MURDER'] as int,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                  DoughnutSeries<Map<String, dynamic>, String>(
                    dataSource: chartData,
                    xValueMapper: (Map<String, dynamic> data, _) => 'Rape',
                    yValueMapper: (Map<String, dynamic> data, _) => data['RAPE'] as int,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}


class CustomTextStyles {

  // Title text style
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMediumGreenA400 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.greenA400,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumMedium => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleSmallOnPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
}

extension on TextStyle {
  TextStyle get spaceGrotesk {
    return copyWith(
      fontFamily: 'Space Grotesk',
    );
  }
}

class _CrimData {
  _CrimData(this.year, this.crimes);

  final String year;
  final num crimes;

}






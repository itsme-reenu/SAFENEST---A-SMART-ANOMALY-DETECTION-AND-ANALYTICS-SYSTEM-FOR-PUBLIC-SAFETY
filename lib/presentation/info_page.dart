import 'package:flutter/material.dart';
import 'package:image_clsf/presentation/dashboard.dart';
import 'package:image_clsf/theme/theme_helper.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeHelper().themeData();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Image.asset(
              'assets/images/image1_0.jpg', // Replace this with your image path
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'SafeNest [Ultimate Protection]',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to SafeNest Security Application. '
                    'Quick access to key features like safety Prediction using camera captured images and alert systems through Email.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Educational content on personal safety practices, self-defense techniques, and emergency preparedness.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Dashboard()));
              },
              child: const Text('Dashboard', style: TextStyle(color: Colors.white, fontSize: 20)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: themeData.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Increase button size
              ),
            ),
          ],
        ),
      ),

    );
  }
}

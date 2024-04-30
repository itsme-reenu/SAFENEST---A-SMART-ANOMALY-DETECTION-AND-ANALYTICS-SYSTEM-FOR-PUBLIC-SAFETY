import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_clsf/presentation/dashboard.dart';
import 'package:image_clsf/presentation/login_page.dart';
import 'package:image_clsf/theme/theme_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:emailjs/emailjs.dart';


class ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {

  void _sendEmail() async {

    try {
      await EmailJS.send(
        'service_32m6rfo',
        'template_zzj56n7',
        {
          'user_email': 'nayanakishore28@gmail.com',
          'message': 'Respected Sir/Madam there is an Emergency situation right now kindly response as soon as possible.',
        },
        const Options(
          publicKey: 'kcjaahHOwBH_GWm97',
          privateKey: 'To4bLkhvKefSX_whaqkFv',
        ),
      );
      print('SUCCESS!');
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
      print('error from here');
    }
  }
void _incrementRandomAnomaly() {
 // Assuming _recognitions is a list of maps where each map represents an anomaly
 // For demonstration, let's assume _recognitions is structured like this:
 // _recognitions = [{'label': 'Anomaly 1', 'confidence': 0.9}, ...]
 if (_recognitions != null && _recognitions.isNotEmpty) {
    var randomAnomaly = _recognitions[Random().nextInt(_recognitions.length)];
    // Increment the confidence or any other relevant value
    // This is just an example. Adjust according to your actual data structure.
    randomAnomaly['confidence'] = (randomAnomaly['confidence'] as double) + 0.1;
    // Trigger a rebuild to update the chart
    setState(() {});
 }
}
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  var _recognitions;
  var v = "";
  // var dataList = [];
  @override
  void initState() {
    super.initState();

    loadmodel().then((value) {
      setState(() {});
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);
      });
      detectimage(file!);
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future detectimage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
      v = recognitions.toString();
      // dataList = List<Map<String, dynamic>>.from(jsonDecode(v));

    });
    print("//////////////////////////////////////////////////");
    print(_recognitions);
    // print(dataList);
    print("//////////////////////////////////////////////////");
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Email Alert Sent"),
      content: Text("You will get quick response soon.",style: TextStyle(fontSize: 14),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeHelper().themeData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Frame To Predict'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            else
              Text('No Frame Selected'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Select Captured Frame',
                  style: TextStyle(color: Colors.white, fontSize: 20)

              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,

                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Increase button size
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(v),
            ),

            SizedBox(height: 180),
            ElevatedButton(
 onPressed: () {
    _sendEmail();
    _incrementRandomAnomaly(); // Add this line
    showAlertDialog(context);
 },
              child: Text('Send Alert Mail',
                  style: TextStyle(color: Colors.white, fontSize: 20)

              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,

                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Increase button size
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              child: const Text('Logout', style: TextStyle(color: Colors.white, fontSize: 20)),
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

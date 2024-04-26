import 'dart:io' as io;
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_clsf/core/app_export.dart';
import 'package:image_clsf/image_prediction.dart';
import 'package:image_clsf/presentation/camera_pack.dart';
import 'package:image_clsf/presentation/login_page.dart';
import 'package:image_clsf/widgets/custom_image_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_clsf/logic/camera_module.dart';
import 'package:image_clsf/theme/theme_helper.dart';
import 'package:tflite_v2/tflite_v2.dart';

import '../widgets/camera_module.dart';


// Ensure this file exists and contains your Firebase configuration

const kModelName = "model"; // Replace with your model name

class ModelLogic extends StatefulWidget {

  const ModelLogic({Key? key,required cameras}) : super(key: key);


  @override
  State<ModelLogic> createState() => _ModelLogicState();
}



class _ModelLogicState extends State<ModelLogic> {
  FirebaseCustomModel? model;
  bool isProcessingComplete = false;
  String modelOutput = "";
  var _recognitions;
  var v = "";

  @override
  void initState() {
    super.initState();
    initWithLocalModel();
  }

  initWithLocalModel() async {
    final _model = await FirebaseModelDownloader.instance.getModel(
        kModelName, FirebaseModelDownloadType.localModelUpdateInBackground);

    setState(() {
      model = _model;
    });
  }
  
Future<String> loadLabels() async {
 return await rootBundle.loadString('assets/labels.txt');
}

  Future<XFile?> pickImageFromGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        String modelOutput = await runModelOnImage(image);
        print("Model output: $modelOutput");
        final Map<String, String> labels = await readLabels();
        print("Labels: $labels");
        final String label = labels[modelOutput] ?? "Default Label";
        print("Matched label: $label");
        // Update the state variables
        setState(() {
          isProcessingComplete = true;
          modelOutput == label;
        });
      }
      return image;
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  Future<String> runModelOnImage(XFile image) async {
    // Process the image and run the model
   // This is a placeholder for your actual model processing logic
   String result = "Model output";

   return result;
  }

  Future<Map<String, String>> readLabels() async {
    String labelsContent = await loadLabels();

    final List<String> lines = labelsContent.split('\n');
    final Map<String, String> labels = {};
    for (var i = 0; i < lines.length; i++) {
      labels[i.toString()] = lines[i];
    }
    return labels;
  }

  void captureAndProcessImage() async {
    // Navigate to a new screen that contains the CameraModule widget
    // Pass a callback function to CameraModule
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: CameraModule(
              onImageCaptured: (XFile? image) async {
                if (image != null) {
                  final String modelOutput = await runModelOnImage(image);
                  final Map<String, String> labels = await readLabels();
                  final String label = labels[modelOutput] ?? "Unknown";
                  // Display the label to the user
                  //print("Model output: $label");

            
                }
                // Navigate back to the previous screen after processing the image
                //Navigator.pop(context);

              },
            ),
          ),
        ),
    );
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }


  Future detectimage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
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

  void captureAndProcessImages() async {
    // Navigate to a new screen that contains the CameraModule widget
    // Pass a callback function to CameraModule
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: CameraModule(
            onImageCaptured: (XFile? image) async {
              if (image != null) {
                print("image found");

              }

              // Navigate back to the previous screen after processing the image

              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    ThemeData themeData = ThemeHelper().themeData();

    return Theme(
      data: themeData, // Apply the theme data from the ThemeHelper
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData, // Apply the theme data to the MaterialApp
        home: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Smart Anomaly Detection App'),
          // ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 23.v),
                    CustomImageView(
                      imagePath: ImageConstant.imgImage1013,
                      height: 150.v,
                      width: 390.h,
                    ),
                    SizedBox(height: 113.v),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: themeData.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: model != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                
                                     'Model name: ${model!.name}',
                                     style: TextStyle(color: Colors.white), // Set the text color to white
                                    ),
                                    Text(
                                     'Model size: ${model!.size}',
                                     style: TextStyle(color: Colors.white), ),
                                     //Text("Model output: abuse", style: TextStyle(color: Colors.white)),
                                     // Set the text color to white
                                  ],
                                )
                              : const Text("Model 334321"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>MainPage(cameras: cameras,)));
                      },
                      child: const Text('Capture and Process Image', style: TextStyle(color: Colors.white, fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, 
                        backgroundColor: themeData.primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Increase button size
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context)=>ImagePickerDemo()));
                      },
                      child: const Text('Pick Image from Gallery', style: TextStyle(color: Colors.white, fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, 
                        backgroundColor: themeData.primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Increase button size
                      ),
                    ),
                    const SizedBox(height: 130),
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
            ),
          ),
        ),
      ),
    );
  }
}

class ImageConstant {

  // Image folder path
  static String imagePath = 'assets/images';

  // Galileo design images
  static String imgDepth5Frame0 = '$imagePath/img_depth_5_frame_0.png';

  static String imgDepth5Frame0201x358 =
      '$imagePath/img_depth_5_frame_0_201x358.png';

  // Galileo design - Tab Container images
  static String imgDepth6Frame0 = '$imagePath/img_depth_6_frame_0.svg';

  static String imageNotFound = 'assets/images/image_not_found.png';

  // Replace 'default_image.png' with the actual default image path
  static String imgImage1011 = '$imagePath/img_image1_0_1_1.png';
  static String imgImage1012 = '$imagePath/img_image0_0_1.png';
  static String imgImage1013 = '$imagePath/img_image_2.png';
  static String imgImage4 = '$imagePath/checkimage.png';
}

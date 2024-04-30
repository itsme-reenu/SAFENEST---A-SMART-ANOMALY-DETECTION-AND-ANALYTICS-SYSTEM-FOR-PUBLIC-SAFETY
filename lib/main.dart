import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_clsf/core/utils/size_utils.dart';
import 'package:image_clsf/firebase_options.dart';
import 'package:image_clsf/logic/camera_module.dart';
import 'package:image_clsf/presentation/carousel_design.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

import 'theme/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ThemeHelper().changeTheme('primary');
  cameras = await availableCameras();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme, // Ensure theme is defined or imported
          title: 'SafeNest',
          debugShowCheckedModeBanner: false,
          home: CarouselScreen(),
        );
      },
    );
  }
}

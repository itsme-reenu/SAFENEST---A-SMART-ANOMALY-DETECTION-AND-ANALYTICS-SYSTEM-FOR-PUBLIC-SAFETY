import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


List<CameraDescription> cameras = [];

class CameraModule extends StatefulWidget {
 final Function(XFile?) onImageCaptured;

 CameraModule({required this.onImageCaptured});

 @override
 _CameraModuleState createState() => _CameraModuleState();
}

class _CameraModuleState extends State<CameraModule> {
 late CameraController controller;
 late Future<void> initializeControllerFuture;

 Future<void> saveImageToExternalStorage(String filePath) async {
    // Request permission to write to external storage
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    // Get the external storage directory
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      print("Couldn't get the external storage directory");
      return;
    }

    // Create a new file in the external storage directory
    final newFile = File('${directory.path}/${DateTime.now().toIso8601String()}.jpg');

    // Copy the image file to the new file
    final originalFile = File(filePath);
    await originalFile.copy(newFile.path);

    print("Image saved to external storage: ${newFile.path}");
 }

 @override
 void initState() {
    super.initState();
    initializeCamera();
 }

 void initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );

    initializeControllerFuture = controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
 }

 @override
 Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final screenWidth = MediaQuery.of(context).size.width;
          return Scaffold(
            body: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                try {
                  final XFile? file = await controller.takePicture();
                  if (file != null) {
                    widget.onImageCaptured(file);
                    await saveImageToExternalStorage(file.path);
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Icon(Icons.camera),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
 }

 @override
 void dispose() {
    controller.dispose();
    super.dispose();
 }
}

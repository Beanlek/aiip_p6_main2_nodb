// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenPage();
}

class _HomeScreenPage extends State<HomeScreen> {
  late CameraController controller;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Hello World!'),
          SizedBox(
            height: screenHeight - 100,
            width: screenWidth - 100,
            child: FutureBuilder(
              future: initializationCamera(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                          aspectRatio: 2 / 3, child: CameraPreview(controller)),
                      AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Image.asset(
                            'assets/images/frame-1.png',
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                        bottom: 40,
                        child: InkWell(
                          onTap: () => onTakePicture(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    ));
  }

  Future<void> initializationCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(
        cameras[EnumCameraDescription.front.index], ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420);

    await controller.initialize();
  }

  onTakePicture() async {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    await controller.takePicture().then((XFile xfile) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  insetPadding: EdgeInsets.symmetric(vertical: 100),
                  title: Text('Take Picture'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Image.file(
                            File(xfile.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                        spaceVertical(15),
                        Text('Is this your picture?'),
                        spaceVertical(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: Text('Yes, Save')),
                            spaceHorizontal(15),
                            ElevatedButton(
                                onPressed: () {}, child: Text('No, Retake')),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
      }
      return;
    });
  }
}

enum EnumCameraDescription { front, back }

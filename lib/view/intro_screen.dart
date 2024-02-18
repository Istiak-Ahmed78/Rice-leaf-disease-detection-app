import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_web_app/view/image_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({
    super.key,
    required this.cameras,
  });
  final List<CameraDescription> cameras;
  final String assetName = 'assets/leaf_test.jpeg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.purple,
        highlightElevation: 50,
        onPressed: () => Get.to(() => CameraScreen()),
        child: const Text('Start'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    assetName,
                    fit: BoxFit.fitWidth,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

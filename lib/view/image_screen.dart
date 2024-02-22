import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ml_web_app/services.dart';
import 'package:ml_web_app/view/methods.dart';
import 'bottom_sh.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.cameras});
  final List<CameraDescription> cameras;
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  File? capturedFile;
  bool isLoading = false;
  void setLoadingState(bool loading) {
    isLoading = loading;
    setState(() {});
  }

  void predictImage() async {
    if (capturedFile != null) {
      changeLoadingState(true);
      Repo().uploadImage(capturedFile!).then((res) {
        changeLoadingState(false);
        if (res?.predicted != null && res?.predicted != '') {
          double possibility = res?.confidance ?? 0;
          possibility = possibility * 100;

          if (possibility < 10) {
            poorValidationResult(context);
          } else {
            showResultSheet(res!, context);
          }
        } else {
          changeLoadingState(false);
          showNoResultPopuos(context);
        }
      });
    }
  }

  void capture() async {
    XFile? capturedFileXFile = await controller.takePicture();
    capturedFile = File(capturedFileXFile.path);
    setState(() {});
    predictImage();
  }

  void pickImage() async {
    XFile? capturedFileXFile = await ImagePicker().pickImage(imageQuality: 80, source: ImageSource.gallery);
    if (capturedFileXFile != null) {
      capturedFile = File(capturedFileXFile.path);
      setState(() {});
      predictImage();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Stack(
        children: [
          capturedFile != null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(
                    capturedFile!,
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: CameraPreview(controller)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: capture,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                    ),
                  ),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blue,
                          )),
                      child: const Icon(
                        Icons.image,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: GestureDetector(
                onTap: Get.back,
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showNoResultPopuos(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: const Center(
              child: Text('Sorry, couldnot found any result'),
            ),
          ),
        );
      });
}

void poorValidationResult(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: const Center(
              child: Text('Your image may not of leaf'),
            ),
          ),
        );
      });
}

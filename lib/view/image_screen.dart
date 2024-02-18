import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ml_web_app/services.dart';
import 'package:ml_web_app/view/methods.dart';
import 'package:ml_web_app/models/response_model.dart';
import 'bottom_sh.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
  });
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? capturedFile;
  bool isLoading = false;
  void setLoadingState(bool loading) {
    isLoading = loading;
    setState(() {});
  }

  void predictImage() async {
    if (capturedFile != null) {
      changeLoadingState(true);
      ResponseModel? res = await Repo().uploadImage(capturedFile!);
      changeLoadingState(false);
      if (res != null && res != '') {
        print(res);
        showSheet(res, context);
      }
    }
  }

  void pickImage(ImageSource imageSource) async {
    XFile? capturedFileXFile = await ImagePicker().pickImage(source: imageSource);
    if (capturedFileXFile != null) {
      capturedFile = File(capturedFileXFile.path);
      setState(() {});
      predictImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              : SizedBox(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width, child: Text('Pick image')),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => pickImage(ImageSource.camera),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blue,
                          )),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => pickImage(ImageSource.gallery),
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

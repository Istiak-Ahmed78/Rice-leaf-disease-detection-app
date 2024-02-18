import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ml_web_app/services.dart';
import 'package:ml_web_app/methods.dart';
import 'package:ml_web_app/models/response_model.dart';
import 'bottom_sh.dart';
import "package:images_picker/images_picker.dart";

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

  void pickImage() async {
    List<Media>? capturedFileXFile = await ImagesPicker.openCamera(
      pickType: PickType.image,
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.custom,
        cropType: CropType.rect, // currently for android
      ),
    );
    if (capturedFileXFile != null) {
      // predictImage();
      String? croppedImagePath = await cropImage(context, capturedFileXFile.first.path);
      if (croppedImagePath != null) {
        capturedFile = File(croppedImagePath);
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              : SizedBox(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: pickImage,
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

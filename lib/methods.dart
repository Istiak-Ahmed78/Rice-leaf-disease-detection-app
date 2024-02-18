import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';

void changeLoadingState(bool st) {
  if (st) {
    EasyLoading.show();
  } else {
    EasyLoading.dismiss();
  }
}

String convertNumber(int eng) {
  String bengali = '';
  for (int i = 0; i < eng.toString().length; i++) {
    switch (eng.toString()[i]) {
      case '1':
        bengali = '$bengali১';
        break;
      case '2':
        bengali = '$bengali২';
        break;
      case '3':
        bengali = '$bengali৩';
        break;
      case '4':
        bengali = '$bengali৪';
        break;
      case '5':
        bengali = '$bengali৫';
        break;
      case '6':
        bengali = '$bengali৬';
        break;
      case '7':
        bengali = '$bengali৭';
        break;
      case '8':
        bengali = '$bengali৮';
        break;
      case '9':
        bengali = '$bengali৯';
        break;
      default:
        bengali = '$bengali.';
    }
  }
  return bengali;
}

Future<String?> cropImage(BuildContext context, String imageFilePath) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFilePath,
    aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9],
    uiSettings: [
      AndroidUiSettings(toolbarTitle: 'Cropper', toolbarColor: Colors.deepOrange, toolbarWidgetColor: Colors.white, initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false),
    ],
  );
  return croppedFile?.path;
}

import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ScannerScreenController extends GetxController {
  static ScannerScreenController get to => Get.find();
  File? imageFile;
  Rx<String?> result = Rx(null);
  RxBool busy = false.obs;

  Future<void> pickImage() async {
    result.value = null;
    update();
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      imageFile = value?.path == null ? null : File(value!.path);
      update();
    });
  }

  // void predict() async {
  //   if (imageFile != null) {
  //     busy.value = true;
  //     update();
  //     try {
  //       final response = await Repo().uploadImage(imageFile!);
  //       result.value = response;
  //       busy.value = false;
  //       update();
  //     } catch (e) {
  //       busy.value = false;
  //       update();
  //       Get.snackbar('Failed', e.toString());
  //     }
  //   } else {
  //     Get.snackbar('Failed', 'Image not selected');
  //   }
  // }
}

import 'package:get/get.dart';
import 'scanner_screen_controller.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScannerScreenController());
  }
}

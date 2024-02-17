import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ml_web_app/binding.dart';
import 'view/intro_screen.dart';

late List<CameraDescription> _cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: GlobalBinding(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroScreen(
        cameras: _cameras,
      ),
      builder: EasyLoading.init(),
    );
  }
}

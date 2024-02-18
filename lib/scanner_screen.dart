import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'scanner_screen_controller.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Camera Demo'),
      ),
      body: GetBuilder<ScannerScreenController>(builder: (controller) {
        return Center(
          child: controller.imageFile == null
              ? ElevatedButton(
                  onPressed: () {},
                  child: const Text('Choose image'),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.7,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Image.file(
                        controller.imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    !controller.busy.value ? ElevatedButton(onPressed: () {}, child: const Text('Predict')) : const CircularProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Reselect Image'),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    controller.result.value == null ? const SizedBox() : Text(controller.result.value.toString())
                  ],
                ),
        );
      }),
    );
  }
}

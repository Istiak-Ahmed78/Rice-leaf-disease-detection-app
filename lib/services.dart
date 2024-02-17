import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ml_web_app/utils.dart';
import 'models/response_model.dart';

const baseUrl = 'https://rice-leaf-disease-detection-717d158cc115.herokuapp.com';

class Repo {
  // Future<void> ping() async {
  //   try {
  //     var response = await http.get(Uri.parse('$baseUrl/ping/'));
  //     if (response.statusCode == 200) {
  //       var responseBody = response..body;
  //       print(responseBody);
  //     } else {
  //       print('Image upload failed: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Image upload error: $e');
  //   }
  // }

  Future<ResponseModel?> uploadImage(File selectedFile) async {
    if (await hasInternetConnection()) {
      final uri = Uri.parse('$baseUrl/predict');
      final request = http.MultipartRequest('POST', uri);
      final file = await http.MultipartFile.fromPath('file', selectedFile.path);
      request.files.add(file);

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          final responseData = await response.stream.bytesToString();
          final jsonResponse = json.decode(responseData) as Map<String, dynamic>;
          return ResponseModel(predicted: jsonResponse['Predicted'], confidance: jsonResponse['Confidance']);
        } else {
          return Future.error('Failed to upload');
        }
      } catch (e) {
        return Future.error(e.toString());
      }
    } else {
      Get.snackbar('No internet', 'You are not connected to the internet', snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }
}

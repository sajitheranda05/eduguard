import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ImageUploadController extends GetxController {
  var isLoading = false.obs;
  static const String flaskServerUrl = 'http://192.168.1.102:5000/upload';

  Future<Map<String, dynamic>> uploadImageAndFetchResult(File imageFile) async {
    isLoading.value = true;
    final url = Uri.parse(flaskServerUrl);
    var request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    try {
      // Send the request and handle the response
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var result = jsonDecode(responseData.body);
        print("Response data: $result"); // Debugging print

        // Check the returned JSON structure
        String detectedClass = result['detectedClass'];
        double confidence = result['confidence'];

        return {'detectedClass': detectedClass, 'confidence': confidence};
      } else {
        print(
            "Server returned status code ${response.statusCode}"); // Debugging print
        return {'detectedClass': 'error', 'confidence': 0.0};
      }
    } catch (e) {
      print("Error during image upload: $e"); // Debugging print
      return {'detectedClass': 'error', 'confidence': 0.0};
    } finally {
      isLoading.value = false;
    }
  }
}

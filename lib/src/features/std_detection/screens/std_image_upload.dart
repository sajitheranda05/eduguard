import 'dart:io';
import 'package:eduguard/src/features/std_detection/controllers/image_upload_controller.dart';
import 'package:eduguard/src/features/std_detection/screens/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadPopup extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final ImageUploadController controller = Get.put(ImageUploadController());
  ImageUploadPopup({super.key});

  void _pickImage(bool fromCamera) async {
    XFile? image;
    if (fromCamera) {
      image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      File imageFile = File(image.path);

      // Navigate to the ImageView page to view the selected image
      Get.to(() => ImageView(
            imagePath: image!.path,
            isLoading: true,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(), // Close the bottom sheet on outside tap
      child: Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), // Only top corners rounded
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Upload Photo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Space between title and icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gallery Container
                GestureDetector(
                  onTap: () {
                    _pickImage(false);
                    Get.back();
                  },
                  child: buildImagePickerIcon(Icons.photo_library, 'Gallery'),
                ),
                const SizedBox(width: 25), // Gap between icons

                // Camera Container
                GestureDetector(
                  onTap: () {
                    _pickImage(true);
                    Get.back();
                  },
                  child: buildImagePickerIcon(Icons.camera, 'Camera'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImagePickerIcon(IconData icon, String label) {
    return Container(
      width: 140, // Fixed width
      height: 130, // Fixed height
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFBFC5C6), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFC7DBDE), // Light green background
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,
                color: const Color(0xFF0C6170),
                size: 30), // Dark green icon color
          ),
          const SizedBox(height: 10), // Space between icon and text
          Text(label,
              style: const TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }
}

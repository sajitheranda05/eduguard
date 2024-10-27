import 'dart:io';
import 'package:eduguard/src/features/std_detection/controllers/image_upload_controller.dart';
import 'package:eduguard/src/features/std_detection/screens/std_detection_results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageView extends StatelessWidget {
  final String imagePath; // Path to the selected image
  final bool isLoading;
  final ImageUploadController controller = Get.put(ImageUploadController());

  ImageView({
    super.key,
    required this.imagePath,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Container(
          color: const Color(0xfff5f9f8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imagePath.isNotEmpty)
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                      maxHeight: 400,
                    ),
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const Center(
                              child: Text('Error loading image'));
                        },
                      ),
                    ),
                  )
                else
                  const Center(child: Text('No image selected')),
                const SizedBox(height: 30),
                if (controller.isLoading.value)
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF0C6170)),
                  )
                else
                  SizedBox(
                    width: 320,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(130, 40),
                            backgroundColor: const Color(0xFF9FA2A3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: const Text('Re-upload',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            File imageFile = File(imagePath);
                            var result = await controller
                                .uploadImageAndFetchResult(imageFile);

                            Get.to(() => STDDetected(
                                  imagePath: imagePath,
                                  isLoading: false,
                                  detectedClass: result['detectedClass'],
                                  confidence: result['confidence'],
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(130, 40),
                            backgroundColor: const Color(0xff0c6170),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: const Text('Proceed',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

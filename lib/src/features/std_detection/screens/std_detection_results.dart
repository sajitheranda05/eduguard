import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class STDDetected extends StatelessWidget {
  final String imagePath;
  final bool isLoading;
  final String detectedClass;
  final double confidence;

  const STDDetected({
    Key? key,
    required this.imagePath,
    required this.isLoading,
    required this.detectedClass,
    required this.confidence,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHealthy = detectedClass.toLowerCase() == 'healthy';
    bool isOther = detectedClass.toLowerCase() == 'other';
    bool isError = detectedClass.toLowerCase() == 'error';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: const Color(0xfff5f9f8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath.isNotEmpty)
                Container(
                  constraints:
                      const BoxConstraints(maxWidth: 150, maxHeight: 200),
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Text('Error loading image')),
                    ),
                  ),
                )
              else
                const Center(child: Text('No image selected')),
              const SizedBox(height: 20),
              Visibility(
                visible: isLoading,
                child: const Column(
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF0C6170)),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Results are loading...',
                      style: TextStyle(fontSize: 16, color: Color(0xFF0C6170)),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !isLoading,
                child: Column(
                  children: [
                    if (isError)
                      const Text(
                        'Error: Unable to process the image. Please try again.',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 18, color: Color(0xffd32f2f)),
                      )
                    else if (isHealthy)
                      const Column(
                        children: [
                          Text(
                            'CONGRATULATIONS !!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, color: Color(0xff1e2425)),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Based on the analysis, there are no signs of infection. You are healthy!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff9fa2a2)),
                          ),
                        ],
                      )
                    else if (isOther)
                      Column(
                        children: [
                          const Text(
                            'WE ARE SORRY !!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, color: Color(0xff1e2425)),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Unfortunately, there’s a $confidence% chance you might be infected. We can’t exactly detect the type. Please seek medical advice.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xff9fa2a2)),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          const Text(
                            'WE ARE SORRY !!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, color: Color(0xff1e2425)),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'There’s a $confidence% chance you might be infected with $detectedClass. Consult a medical specialist.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xff9fa2a2)),
                          ),
                        ],
                      ),
                    TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        foregroundColor: const Color(0xff37be9d),
                        side: const BorderSide(
                            color: Color(0xff37be9d), width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        minimumSize: const Size(120, 40),
                      ),
                      child: const Text(
                        'Back',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff37be9d)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*import 'package:eduguard/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class STDNotDetected extends StatelessWidget {
  const STDNotDetected({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xfff5f9f8),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0, // Center horizontally
              right: 0, // Center horizontally
              top: 0, // Remove the specific top value
              bottom: 0, // Center vertically
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.congradulations,
                    width: 300,
                    height: 215,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'CONGRATULATIONS !!!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 24,
                                color: Color(0xff1e2425),
                                fontFamily: 'Poppins-SemiBold',
                                fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 320,
                            child: Text(
                              'Based on the analysis, there are no signs of infection.\n Keep up the good work in maintaining your health.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 14,
                                  color: Color(0xff9fa2a2),
                                  fontFamily: 'Poppins-Regular',
                                  fontWeight: FontWeight.normal),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      TextButton(
                        onPressed: () => Get.back(),
                        style: TextButton.styleFrom(
                          side: const BorderSide(
                              color: Color(0xff37be9d),
                              width: 1), // Border color and width
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(40), // Border radius
                          ),
                          padding: EdgeInsets.zero, // Remove internal padding
                          minimumSize:
                              const Size(120, 40), // Set the exact size
                          alignment:
                              Alignment.center, // Align content to the center
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff37be9d),
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

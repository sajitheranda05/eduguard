import 'package:eduguard/src/features/std_detection/screens/std_image_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class STDInfo extends StatelessWidget {
  const STDInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f9f8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 300,
              child: Text(
                'Here is a quick overview of how it works:',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff1e2425),
                    fontFamily: 'Poppins-SemiBold',
                    fontWeight: FontWeight.w600),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoItem('1. Upload Your Photo',
                'Click "Upload Photo" to select a clear image of the infected or suspected area from your device.'),
            const SizedBox(height: 10),
            _buildInfoItem('2. Image Analysis',
                'Once the photo is uploaded, our system will analyze it to check for signs of disease or confirm healthy.',
                additionalInfo:
                    '(Please note that in the current version of the app, you could exactly detect Syphilis, Gonorrhea and Genital Warts only.)',
                additionalColor: const Color(0xffe46363)),
            const SizedBox(height: 10),
            _buildInfoItem('3. Display Results',
                'After the analysis is complete, the results will be displayed on your screen, with recommendations for further consultations if needed.'),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(130, 40),
                    backgroundColor: const Color(0xFF9FA2A3),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(40), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Poppins-Medium',
                    ),
                  ),
                ),
                const SizedBox(width: 60),
                ElevatedButton(
                  onPressed: () {
                    Get.bottomSheet(
                      ImageUploadPopup(),
                      isDismissible:
                          true, // Allows dismissing by tapping outside

                      enableDrag: true,
                      backgroundColor:
                          Colors.transparent, // Make the background transparent
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(130, 40),
                    backgroundColor: const Color(0xff0c6170),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text(
                    'Upload Photo',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xffffffff),
                      fontFamily: 'Poppins-Medium',
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String description,
      {String? additionalInfo,
      Color additionalColor = const Color(0xff9fa2a3)}) {
    return SizedBox(
      width: 320, // Set fixed width for all texts
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xff1e2425),
              fontFamily: 'Poppins-Regular',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff9fa2a3),
                fontFamily: 'Poppins-Medium',
                fontWeight: FontWeight.w500,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (additionalInfo != null)
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 4),
              child: Text(
                additionalInfo,
                style: TextStyle(
                  fontSize: 14,
                  color: additionalColor,
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

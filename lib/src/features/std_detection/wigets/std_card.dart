import 'package:eduguard/src/features/std_detection/models/std_model.dart';
import 'package:eduguard/src/features/std_detection/screens/std_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class STDCard extends StatelessWidget {
  const STDCard({super.key, required this.std});

  final STDModel std;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), offset: Offset(0, 4), blurRadius: 8),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10.0), // Rounds the corners by 10px
                    child: AspectRatio(
                      aspectRatio: 2 / 1, // Set the aspect ratio to 2:1
                      child: Image.network(
                        std.stdImg,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, top: 0, right: 5, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          std.stdName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 14,
                              color: Color(0xff1e2425),
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.normal),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                std.stdDescription,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: Color(0xff9fa2a2),
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.normal),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            GestureDetector(
              onTap: () => Get.to(() => STDView(
                    std: std,
                    symptoms: const [],
                  )),
              child: const Text(
                'Learn More',
                textAlign: TextAlign.left,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 12,
                    color: Color(0xff37be9d),
                    fontFamily: 'Poppins-Regular',
                    fontWeight: FontWeight.normal),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

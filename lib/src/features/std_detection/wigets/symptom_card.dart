import 'package:flutter/material.dart';

class SymptomCard extends StatelessWidget {
  final String symptomImg; // The URL of the symptom image
  final String symptomName; // The name of the symptom
  const SymptomCard(
      {super.key, required this.symptomImg, required this.symptomName});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10.0), // Rounds the corners by 10px
              child: AspectRatio(
                aspectRatio: 3 / 2, // Set the aspect ratio to 3:2
                child: Image.network(
                  symptomImg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              symptomName,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 12,
                                  color: Color(0xff1e2425),
                                  fontFamily: 'Poppins-Regular',
                                  fontWeight: FontWeight.normal),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

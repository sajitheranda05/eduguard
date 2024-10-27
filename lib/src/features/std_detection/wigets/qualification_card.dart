import 'package:flutter/material.dart';

class QualificationCard extends StatelessWidget {
  final String degree;
  final String campusName;
  const QualificationCard(
      {super.key, required this.degree, required this.campusName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), offset: Offset(0, 4), blurRadius: 8),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xffDBF5F0), // Background color
                borderRadius:
                    BorderRadius.circular(27.5), // Circular shape (half of 55)
              ),
              child: const Icon(
                Icons.school_rounded, // Your desired icon
                color: Color(0xff37BE9E), // Icon color (#37BE9E)
                size: 24, // Icon size (adjust to fit nicely)
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campusName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 12,
                          color: Color(0xff1e2425),
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.normal),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            degree,
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
      ),
    );
  }
}

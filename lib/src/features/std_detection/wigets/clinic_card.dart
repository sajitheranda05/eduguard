import 'package:flutter/material.dart';

class ClinicCard extends StatelessWidget {
  final String clinicName;
  final String clinicPhone;
  final String clinicAddress;
  final String clinicDescription;
  const ClinicCard(
      {super.key,
      required this.clinicName,
      required this.clinicPhone,
      required this.clinicAddress,
      required this.clinicDescription});

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xffDBF5F0), // Background color
                borderRadius: BorderRadius.circular(
                    10), // Circular shape (or adjust as needed)
              ),
              child: const Icon(
                Icons.medical_services, // Your desired icon
                color: Color(0xff37BE9E), // Icon color
                size: 30, // Icon size
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                clinicName,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
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
                                      clinicAddress,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          color: Color(0xff9fa2a2),
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.normal),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      clinicPhone,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 10,
                                          color: Color(0xffbfc4c5),
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.normal),
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
                    const SizedBox(height: 8),
                    Text(
                      clinicDescription,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 10,
                          color: Color(0xff9fa2a2),
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.normal),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

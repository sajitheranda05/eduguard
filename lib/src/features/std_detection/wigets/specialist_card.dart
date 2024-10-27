import 'package:eduguard/src/features/std_detection/models/specialist_model.dart';
import 'package:eduguard/src/features/std_detection/screens/std_specialist_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialistCard extends StatelessWidget {
  const SpecialistCard({super.key, required this.specialist});

  final SpecialistModel specialist;

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
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the radius as needed
              child: Image.network(
                specialist.specialistImg,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
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
                                specialist.specialistName,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    color: Color(0xff1e2425),
                                    fontFamily: 'Poppins-Medium',
                                    fontWeight: FontWeight.normal),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      specialist.specialization,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          color: Color(0xff9fa2a2),
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.normal),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: Color(0xFFBFC5C6),
                                          size: 18.0,
                                        ),
                                        const SizedBox(width: 3),
                                        Expanded(
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              specialist.specialistCity,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 12,
                                                  color: Color(0xffBFC5C6),
                                                  fontFamily: 'Poppins-Regular',
                                                  fontWeight:
                                                      FontWeight.normal),
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () =>
                          Get.to(() => SpecialistView(specialist: specialist)),
                      child: const Text(
                        'View Profile',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 12,
                            color: Color(0xff37be9d),
                            fontFamily: 'Poppins-Regular',
                            fontWeight: FontWeight.normal),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
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

import 'package:eduguard/src/common_widgets/Screens/appbar.dart';
import 'package:eduguard/src/features/std_detection/models/specialist_model.dart';
import 'package:eduguard/src/features/std_detection/wigets/clinic_card.dart';
import 'package:eduguard/src/features/std_detection/wigets/qualification_card.dart';
import 'package:flutter/material.dart';

class SpecialistView extends StatelessWidget {
  const SpecialistView({super.key, required this.specialist});

  final SpecialistModel specialist;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            specialist.specialistName,
            style: const TextStyle(fontSize: 18.0),
          ),
          showBackArrow: true, // Show the back arrow
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xfff6faf9),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  specialist.specialistImg,
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Wrap(
                                spacing:
                                    10, // Space between the labels horizontally
                                runSpacing:
                                    10, // Space between the labels vertically when wrapping
                                alignment: WrapAlignment
                                    .center, // Aligns the content to the center
                                children: [
                                  // Location label
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                          0xFFC7DBDE), // Updated background color
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      specialist.specialistCity,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(
                                            0xFF0C6170), // Updated text color
                                        fontFamily: 'Poppins-Regular',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  // Specialization label
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                          0xFFC7DBDE), // Updated background color
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      specialist.specialization,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(
                                            0xFF0C6170), // Updated text color
                                        fontFamily: 'Poppins-Regular',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  // Years of experience label
                                  Visibility(
                                    visible: specialist.years
                                        .isNotEmpty, // Only visible if experience is not empty
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFC7DBDE), // Updated background color
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        '${specialist.years} experience', // Display experience value
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(
                                              0xFF0C6170), // Updated text color
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 321,
                                child: Text(
                                  'About',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      specialist.specialistAbout,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 12,
                                          color: Color(0xff9fa2a2),
                                          fontFamily: 'Poppins-Regular',
                                          fontWeight: FontWeight.normal),
                                      maxLines: 50,
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
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'Clinics Availability',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              ListView.builder(
                                itemCount:
                                    specialist.specialistClinic?.length ?? 0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  final clinic =
                                      specialist.specialistClinic?[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0), // Space between items
                                    child: ClinicCard(
                                      clinicName: clinic!.clinicName,
                                      clinicPhone: clinic.clinicPhone,
                                      clinicAddress: clinic.clinicAddress,
                                      clinicDescription:
                                          clinic.clinicDescription,
                                    ), // A custom widget or ListTile to display clinic information
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'Qualifications',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14,
                                      color: Color(0xff1e2425),
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              ListView.builder(
                                itemCount: specialist
                                        .specialistQualifications?.length ??
                                    0,
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  final qualification = specialist
                                      .specialistQualifications![index];
                                  return QualificationCard(
                                    campusName: qualification.campusName,
                                    degree: qualification.degree,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

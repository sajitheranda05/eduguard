import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/features/std_detection/models/clinic_model.dart';
import 'package:eduguard/src/features/std_detection/models/qualification_model.dart';

class SpecialistModel {
  String specialistId;
  String specialistImg;
  String specialistName;
  String specialization;
  String specialistAbout;
  String years;
  String specialistCity;
  bool? isPopular;
  List<ClinicModel>? specialistClinic;
  List<QualificationModel>? specialistQualifications;

  SpecialistModel({
    required this.specialistId,
    required this.specialistImg,
    required this.specialistName,
    required this.specialization,
    required this.specialistAbout,
    required this.years,
    required this.specialistCity,
    required this.isPopular,
    required this.specialistClinic,
    required this.specialistQualifications,
  });

  /// Create empty function for clean code,
  static SpecialistModel empty() => SpecialistModel(
        specialistId: '',
        specialistImg: '',
        specialistName: '',
        specialization: '',
        specialistAbout: '',
        years: '',
        specialistCity: '',
        isPopular: false,
        specialistClinic: [],
        specialistQualifications: [],
      );

  ///Json format
  toJson() {
    return {
      'Specialist_img': specialistImg,
      'Specialist_name': specialistName,
      'Specialization': specialization,
      'Specialist_about': specialistAbout,
      'Experience': years,
      'Specialist_city': specialistCity,
      'isPopular': isPopular,
      'Specialist_clinics': specialistClinic != null
          ? specialistClinic!.map((e) => e.toJson()).toList()
          : [],
      'Specialist_qualifications': specialistQualifications != null
          ? specialistQualifications!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  ///Map Json oriented document snapshot from firebase to model
  factory SpecialistModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return SpecialistModel.empty();
    final data = document.data()!;
    return SpecialistModel(
      specialistId: document.id,
      specialistImg: data['Specialist_img'],
      specialistName: data['Specialist_name'],
      specialization: data['Specialization'],
      specialistAbout: data['Specialist_about'],
      years: data['Experience'],
      specialistCity: data['Specialist_city'],
      isPopular: data['isPopular'] ?? false,
      specialistClinic: (data['Specialist_clinics'] as List<dynamic>)
          .map((e) => ClinicModel.fromJson(e))
          .toList(),
      specialistQualifications:
          (data['Specialist_qualifications'] as List<dynamic>)
              .map((e) => QualificationModel.fromJson(e))
              .toList(),
    );
  }
}

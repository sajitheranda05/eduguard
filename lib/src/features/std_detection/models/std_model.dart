import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduguard/src/features/std_detection/models/symptom_model.dart';

class STDModel {
  String stdId;
  String stdImg;
  String caption;
  String stdName;
  String stdDescription;
  String externalURL;
  bool? isCommon;
  List<SymptomModel>? stdSymptoms;
  String stdPrevention;
  String stdTransmission;

  STDModel({
    required this.stdId,
    required this.stdImg,
    required this.caption,
    required this.stdName,
    required this.stdDescription,
    required this.externalURL,
    required this.isCommon,
    required this.stdSymptoms,
    required this.stdPrevention,
    required this.stdTransmission,
  });

  /// Create empty function for clean code,
  static STDModel empty() => STDModel(
        stdId: '',
        stdImg: '',
        caption: '',
        stdName: '',
        stdDescription: '',
        externalURL: '',
        isCommon: false,
        stdSymptoms: [],
        stdPrevention: '',
        stdTransmission: '',
      );

  ///Json format
  toJson() {
    return {
      'STD_img': stdImg,
      'Caption': caption,
      'STD_name': stdName,
      'STD_description': stdDescription,
      'URL': externalURL,
      'isCommon': isCommon,
      'STD_symptoms': stdSymptoms != null
          ? stdSymptoms!.map((e) => e.toJson()).toList()
          : [],
      'STD_prevention': stdPrevention,
      'STD_transmission': stdTransmission,
    };
  }

  ///Map Json oriented document snapshot from firebase to model
  factory STDModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return STDModel.empty();
    final data = document.data()!;
    return STDModel(
      stdId: document.id,
      stdImg: data['STD_img'],
      caption: data['Caption'],
      stdName: data['STD_name'],
      stdDescription: data['STD_description'],
      externalURL: data['URL'],
      isCommon: data['isCommon'] ?? false,
      stdPrevention: data['STD_prevention'],
      stdTransmission: data['STD_transmission'],
      stdSymptoms: (data['STD_symptoms'] as List<dynamic>)
          .map((e) => SymptomModel.fromJson(e))
          .toList(),
    );
  }
}

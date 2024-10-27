class SymptomModel {
  String symptomId;
  String symptomImg;
  String symptomName;

  SymptomModel({
    required this.symptomId,
    required this.symptomImg,
    required this.symptomName,
  });

  ///Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Symptom_ID': symptomId,
      'Symptom_img': symptomImg,
      'Symptom_name': symptomName,
    };
  }

  ///Map Json oriented document snapshot from firebase to model
  factory SymptomModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    /// if (data.isEmpty) return SymptomModel();

    return SymptomModel(
      symptomId: data.containsKey('Symptom_ID') ? data['Symptom_ID'] : '',
      symptomImg: data.containsKey('Symptom_img') ? data['Symptom_img'] : '',
      symptomName: data.containsKey('Symptom_name') ? data['Symptom_name'] : '',
    );
  }
}

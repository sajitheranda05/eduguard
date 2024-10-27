class QualificationModel {
  String campusId;
  String campusName;
  String degree;

  QualificationModel(
      {required this.campusId, required this.campusName, required this.degree});

  ///Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Campus_ID': campusId,
      'Campus_name': campusName,
      'Degree': degree,
    };
  }

  ///Map Json oriented document snapshot from firebase to model
  factory QualificationModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    //if (data.isEmpty) return QualificationModel();

    return QualificationModel(
        campusId: data.containsKey('Campus_ID') ? data['Campus_ID'] : '',
        campusName: data.containsKey('Campus_name') ? data['Campus_name'] : '',
        degree: data.containsKey('Degree') ? data['Degree'] : '');
  }
}

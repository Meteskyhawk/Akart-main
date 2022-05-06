export 'export.dart';

class MedicationModel {
  String? ilnesstype;
  String? ilnessDescription;
  DateTime? dateCreated;
  bool? medicationCompleted;

  MedicationModel({
    this.ilnesstype,
    this.ilnessDescription,
    this.dateCreated,
    this.medicationCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'jobType': ilnesstype,
      'jobDescription': ilnessDescription,
      'dateCreated': dateCreated,
      'jobCompleted': medicationCompleted,
    };
  }
}

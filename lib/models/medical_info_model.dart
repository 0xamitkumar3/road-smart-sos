class MedicalInfoModel {

  final String bloodGroup;

  final String allergies;

  final String conditions;

  final String medications;

  final String notes;

  MedicalInfoModel({

    required this.bloodGroup,

    required this.allergies,

    required this.conditions,

    required this.medications,

    required this.notes,
  });

  Map<String, dynamic> toJson() {

    return {

      "bloodGroup":
          bloodGroup,

      "allergies":
          allergies,

      "conditions":
          conditions,

      "medications":
          medications,

      "notes":
          notes,
    };
  }

  factory MedicalInfoModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return MedicalInfoModel(

      bloodGroup:
          json["bloodGroup"],

      allergies:
          json["allergies"],

      conditions:
          json["conditions"],

      medications:
          json["medications"],

      notes:
          json["notes"],
    );
  }
}
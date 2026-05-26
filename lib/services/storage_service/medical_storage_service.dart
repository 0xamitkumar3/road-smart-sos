import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/medical_info_model.dart';

class MedicalStorageService {

  static const String
      medicalKey =
          "medical_information";

  Future<void> saveMedicalInfo(
    MedicalInfoModel medicalInfo,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    final encodedData =
        jsonEncode(
      medicalInfo.toJson(),
    );

    await prefs.setString(
      medicalKey,
      encodedData,
    );
  }

  Future<MedicalInfoModel?>
      loadMedicalInfo() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    final data =
        prefs.getString(
      medicalKey,
    );

    if (data == null) {
      return null;
    }

    final decodedData =
        jsonDecode(data);

    return MedicalInfoModel.fromJson(
      decodedData,
    );
  }
}
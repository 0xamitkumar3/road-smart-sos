import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/incident_model.dart';

class HistoryStorageService {

  static const String key =
      "incident_history";

  Future<void> saveIncidents(
    List<IncidentModel> incidents,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    List<String> incidentList =
        incidents.map((incident) {

      return jsonEncode(
        incident.toMap(),
      );
    }).toList();

    await prefs.setStringList(
      key,
      incidentList,
    );
  }

  Future<List<IncidentModel>>
      loadIncidents() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    List<String>? incidentList =
        prefs.getStringList(key);

    if (incidentList == null) {
      return [];
    }

    return incidentList.map((item) {

      return IncidentModel.fromMap(
        jsonDecode(item),
      );
    }).toList();
  }
}
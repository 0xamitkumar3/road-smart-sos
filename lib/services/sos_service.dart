import 'package:cloud_firestore/cloud_firestore.dart';

class SOSService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> sendSOSAlert({

    required String uid,

    required String email,

    required double latitude,

    required double longitude,
  }) async {

    await _firestore
        .collection("sos_alerts")
        .add({

      "uid": uid,

      "email": email,

      "latitude": latitude,

      "longitude": longitude,

      "status": "ACTIVE",

      "createdAt":
          DateTime.now(),
    });
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> saveEmergencyContact({

    required String uid,

    required String name,

    required String phone,
  }) async {

    await _firestore
        .collection("users")
        .doc(uid)
        .collection("emergency_contacts")
        .add({

      "name": name,

      "phone": phone,

      "createdAt":
          DateTime.now(),
    });
  }

  Future<List<Map<String, dynamic>>>
      getEmergencyContacts(
    String uid,
  ) async {

    final snapshot =
        await _firestore
            .collection("users")
            .doc(uid)
            .collection(
              "emergency_contacts",
            )
            .get();

    return snapshot.docs.map((doc) {

      return {

        "id": doc.id,

        ...doc.data(),
      };

    }).toList();
  }

  Future<List<String>>
      getEmergencyNumbers(
    String uid,
  ) async {

    final snapshot =
        await _firestore
            .collection("users")
            .doc(uid)
            .collection(
              "emergency_contacts",
            )
            .get();

    return snapshot.docs.map((doc) {

      return doc["phone"]
          .toString();

    }).toList();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> saveUserData({

    required String uid,

    required String name,

    required String email,

    required String bloodGroup,
  }) async {

    await _firestore
        .collection("users")
        .doc(uid)
        .set({

      "name": name,

      "email": email,

      "bloodGroup": bloodGroup,

      "createdAt":
          DateTime.now(),
    });
  }
}
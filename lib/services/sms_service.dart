import 'package:flutter_sms/flutter_sms.dart';

class SMSService {

  Future<void> sendEmergencySMS({

    required List<String> contacts,

    required String message,
  }) async {

    try {

      await sendSMS(

        message: message,

        recipients: contacts,
      );

    } catch (e) {

      print(
        "SMS ERROR: $e",
      );
    }
  }
}
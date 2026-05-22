import 'dart:async';
import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';

class SensorService {

  final StreamController<bool> _accidentController =
  StreamController<bool>.broadcast();

  Stream<bool> get accidentStream =>
      _accidentController.stream;

  static const double accidentThreshold = 35.0;

  void startMonitoring() {

    accelerometerEventStream().listen((event) {

      double x = event.x;
      double y = event.y;
      double z = event.z;

      double acceleration = sqrt(
        x * x +
            y * y +
            z * z,
      );

      print("Acceleration: $acceleration");

      if (acceleration > accidentThreshold) {

        _accidentController.add(true);
      }
    });
  }

  void dispose() {
    _accidentController.close();
  }
}
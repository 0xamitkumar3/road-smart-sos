import 'dart:async';
import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';

class SensorService {

  final StreamController<bool>
      _accidentController =
          StreamController<bool>.broadcast();

  Stream<bool> get accidentStream =>
      _accidentController.stream;

  static const double
      accidentThreshold = 45.0;

  double accelerometerX = 0;
  double accelerometerY = 0;
  double accelerometerZ = 0;

  double gyroscopeX = 0;
  double gyroscopeY = 0;
  double gyroscopeZ = 0;

  double motionIntensity = 0;

  void startMonitoring() {

    accelerometerEventStream().listen(
      (event) {

        accelerometerX = event.x;
        accelerometerY = event.y;
        accelerometerZ = event.z;

        motionIntensity = sqrt(
          event.x * event.x +
              event.y * event.y +
              event.z * event.z,
        );

        print(
          "Motion Intensity: "
          "$motionIntensity",
        );

        if (motionIntensity >
            accidentThreshold) {

          _accidentController
              .add(true);
        }
      },
    );

    gyroscopeEventStream().listen(
      (event) {

        gyroscopeX = event.x;
        gyroscopeY = event.y;
        gyroscopeZ = event.z;

        print(
          "Gyroscope => "
          "X:$gyroscopeX "
          "Y:$gyroscopeY "
          "Z:$gyroscopeZ",
        );
      },
    );
  }

  void dispose() {

    _accidentController.close();
  }
}
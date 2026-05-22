import 'package:geolocator/geolocator.dart';

class GPSService {

  Future<Position?> getCurrentLocation() async {

    bool serviceEnabled;
    LocationPermission permission;

    // Check if GPS is enabled
    serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return null;
    }

    // Check permissions
    permission =
        await Geolocator.checkPermission();

    // Request permission if denied
    if (permission == LocationPermission.denied) {

      permission =
          await Geolocator.requestPermission();

      if (permission ==
          LocationPermission.denied) {

        return null;
      }
    }

    // Permission permanently denied
    if (permission ==
        LocationPermission.deniedForever) {

      return null;
    }

    // Fetch current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy:
          LocationAccuracy.high,
    );
  }
}
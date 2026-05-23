import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LiveTrackingScreen extends StatelessWidget {

  final double latitude;
  final double longitude;

  const LiveTrackingScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {

    final LatLng accidentLocation =
        LatLng(latitude, longitude);

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: const Text(
          "Live Emergency Tracking",
        ),
      ),

      body: Column(
        children: [

          Expanded(
            child: FlutterMap(

              options: MapOptions(
                initialCenter:
                    accidentLocation,

                initialZoom: 15,
              ),

              children: [

                TileLayer(
                  urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

                  userAgentPackageName:
                  'com.example.road_smart_sos',
                ),

                MarkerLayer(
                  markers: [

                    Marker(
                      point:
                          accidentLocation,

                      width: 80,
                      height: 80,

                      child: Icon(
                        Icons.location_on,
                        size: 50,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),

            decoration: const BoxDecoration(
              color: Color(0xFF1C1F2E),
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                const Text(
                  "Emergency Location",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "Latitude: $latitude",
                ),

                Text(
                  "Longitude: $longitude",
                ),

                const SizedBox(height: 15),

                const Row(
                  children: [

                    Icon(
                      Icons.local_hospital,
                      color: Colors.red,
                    ),

                    SizedBox(width: 10),

                    Text(
                      "Nearby hospitals notified",
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                const Row(
                  children: [

                    Icon(
                      Icons.local_police,
                      color: Colors.blue,
                    ),

                    SizedBox(width: 10),

                    Text(
                      "Police tracking active",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
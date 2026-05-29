import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SOSLocationScreen extends StatelessWidget {

  final double latitude;
  final double longitude;

  const SOSLocationScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {

    final location =
        LatLng(
          latitude,
          longitude,
        );

    return Scaffold(

      backgroundColor:
          const Color(0xFF090B12),

      appBar: AppBar(
        title:
            const Text(
          "SOS Location",
        ),
      ),

      body: FlutterMap(

        options: MapOptions(

          initialCenter:
              location,

          initialZoom: 16,
        ),

        children: [

         TileLayer(
  urlTemplate:
      'https://tile.openstreetmap.de/{z}/{x}/{y}.png',

  userAgentPackageName:
      'com.roadsmartsos.app',
),

          MarkerLayer(

            markers: [

              Marker(

                point: location,

                width: 80,

                height: 80,

                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
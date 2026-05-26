import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../maps/live_tracking_screen.dart';
import '../../services/gps_service/gps_service.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() =>
      _EmergencyScreenState();
}

class _EmergencyScreenState
    extends State<EmergencyScreen> {

  final GPSService gpsService =
      GPSService();

  Position? position;

  String generateSOSMessage() {

    if (position == null) {
      return "Fetching emergency location...";
    }

    return """
🚨 EMERGENCY ALERT 🚨

Possible accident detected.

Live Location:
Latitude: ${position!.latitude}
Longitude: ${position!.longitude}

Please contact emergency services immediately.
""";
  }

  @override
  void initState() {
    super.initState();

    loadLocation();
  }

  Future<void> loadLocation() async {

    Position? currentPosition =
        await gpsService.getCurrentLocation();

    setState(() {
      position = currentPosition;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                Icon(
                  Icons.warning_amber_rounded,
                  size: 130,
                  color: Colors.red.shade400,
                ),

                const SizedBox(height: 30),

                const Text(
                  "SOS SENT",

                  style: TextStyle(
                    fontSize: 42,
                    fontWeight:
                        FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Emergency contacts,\nnearby hospitals and police\nhave been notified.",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 40),

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade400,
                        Colors.red.shade700,
                      ],
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),
                  ),

                  child: const Column(
                    children: [

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Icon(
                            Icons.emergency,
                            color: Colors.white,
                            size: 32,
                          ),

                          SizedBox(width: 12),

                          Text(
                            "EMERGENCY ACTIVE",

                            style: TextStyle(
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,

                        children: [

                          Column(
                            children: [

                              Icon(
                                Icons.sensors,
                                color: Colors.white,
                              ),

                              SizedBox(height: 8),

                              Text(
                                "Sensors",
                              ),

                              SizedBox(height: 4),

                              Text(
                                "ACTIVE",

                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [

                              Icon(
                                Icons.gps_fixed,
                                color: Colors.white,
                              ),

                              SizedBox(height: 8),

                              Text(
                                "GPS",
                              ),

                              SizedBox(height: 4),

                              Text(
                                "LIVE",

                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [

                              Icon(
                                Icons.health_and_safety,
                                color: Colors.white,
                              ),

                              SizedBox(height: 8),

                              Text(
                                "Rescue",
                              ),

                              SizedBox(height: 4),

                              Text(
                                "ALERTED",

                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                    18,
                  ),

                  decoration: BoxDecoration(
                    color:
                        Colors.orange.withValues(
                      alpha: 0.15,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),

                    border: Border.all(
                      color: Colors.orange,
                    ),
                  ),

                  child: const Row(
                    children: [

                      Icon(
                        Icons.notifications_active,
                        color: Colors.orange,
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: Text(
                          "Emergency notifications are being sent to nearby rescue services.",

                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

                  decoration: BoxDecoration(
                    color:
                        const Color(0xFF1C1F2E),

                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),
                  ),

                  child: Column(
                    children: [

                      const Row(
                        children: [

                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),

                          SizedBox(width: 10),

                          Text(
                            "GPS Tracking Active",
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [

                          const Icon(
                            Icons.my_location,
                            color: Colors.green,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              position == null
                                  ? "Fetching location..."
                                  : "Lat: ${position!.latitude}\nLng: ${position!.longitude}",
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Row(
                        children: [

                          Icon(
                            Icons.local_hospital,
                            color: Colors.red,
                          ),

                          SizedBox(width: 10),

                          Text(
                            "Nearest Hospital Alert Sent",
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Row(
                        children: [

                          Icon(
                            Icons.local_police,
                            color: Colors.red,
                          ),

                          SizedBox(width: 10),

                          Text(
                            "Police Station Notified",
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,

                        child:
                            ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.red.shade400,

                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 14,
                            ),

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                16,
                              ),
                            ),
                          ),

                          onPressed: () {

                            if (position !=
                                null) {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      LiveTrackingScreen(
                                    latitude:
                                        position!
                                            .latitude,

                                    longitude:
                                        position!
                                            .longitude,
                                  ),
                                ),
                              );
                            }
                          },

                          icon: const Icon(
                            Icons.map,
                          ),

                          label: const Text(
                            "Open Live Tracking",

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Container(
                        width: double.infinity,

                        padding:
                            const EdgeInsets.all(
                          18,
                        ),

                        decoration:
                            BoxDecoration(
                          color:
                              Colors.red.withValues(
                            alpha: 0.12,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),

                          border: Border.all(
                            color: Colors.red,
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            const Row(
                              children: [

                                Icon(
                                  Icons.sms,
                                  color: Colors.red,
                                ),

                                SizedBox(
                                  width: 10,
                                ),

                                Text(
                                  "Emergency SOS Message",

                                  style:
                                      TextStyle(
                                    fontSize:
                                        18,

                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Text(
                              generateSOSMessage(),

                              style:
                                  const TextStyle(
                                height: 1.5,
                                color:
                                    Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
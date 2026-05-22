import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  fontWeight: FontWeight.bold,
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
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xFF1C1F2E),
                  borderRadius: BorderRadius.circular(24),
                ),

                child: const Column(
                  children: [

                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red),
                        SizedBox(width: 10),
                        Text("GPS Tracking Active"),
                      ],
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.local_hospital,
                            color: Colors.red),
                        SizedBox(width: 10),
                        Text("Nearest Hospital Alert Sent"),
                      ],
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Icon(Icons.local_police,
                            color: Colors.red),
                        SizedBox(width: 10),
                        Text("Police Station Notified"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
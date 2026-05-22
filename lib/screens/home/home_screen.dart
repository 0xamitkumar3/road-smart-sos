import 'package:flutter/material.dart';

import '../../services/sensor_service/sensor_service.dart';
import '../profile/profile_screen.dart';
import '../sos/sos_alert_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final SensorService sensorService =
      SensorService();

  bool accidentDetected = false;

  @override
  void initState() {
    super.initState();

    sensorService.startMonitoring();

    sensorService.accidentStream.listen((detected) {

      if (detected && !accidentDetected) {

        accidentDetected = true;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SOSAlertScreen(),
          ),
        ).then((_) {

          accidentDetected = false;
        });
      }
    });
  }

  @override
  void dispose() {

    sensorService.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: const Text("Smart SOS"),

        actions: [

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },

            icon: const Icon(Icons.person),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            const Text(
              "Road Safety\nMonitoring System",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFF1C1F2E),
                borderRadius: BorderRadius.circular(24),
              ),

              child: const Row(
                children: [

                  Icon(
                    Icons.sensors,
                    color: Colors.red,
                    size: 40,
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    child: Text(
                      "Sensors actively monitoring vehicle status.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.green,
                ),
              ),

              child: const Row(
                children: [

                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),

                  SizedBox(width: 12),

                  Text(
                    "Live Sensor Monitoring Active",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 65,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SOSAlertScreen(),
                    ),
                  );
                },

                icon: const Icon(Icons.warning),

                label: const Text(
                  "Simulate Accident",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
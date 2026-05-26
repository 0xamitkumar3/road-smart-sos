import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/incident_model.dart';

import '../../services/storage_service/history_storage_service.dart';
import '../../services/sensor_service/sensor_service.dart';
import '../../services/notification_service/notification_service.dart';

import '../emergency_contacts/contact_screen.dart';
import '../history/history_screen.dart';
import '../notifications/notification_center_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';
import '../sos/sos_alert_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  final SensorService sensorService =
      SensorService();

  final HistoryStorageService
      historyStorageService =
          HistoryStorageService();

  final NotificationService
      notificationService =
          NotificationService();

  bool accidentDetected = false;

  List<IncidentModel> incidents = [];

  late AnimationController
      pulseController;

  late Animation<double>
      pulseAnimation;

  Timer? liveTimer;

  List<FlSpot> motionSpots = [];

  double graphX = 0;

  @override
  void initState() {
    super.initState();

    pulseController =
        AnimationController(
      vsync: this,
      duration:
          const Duration(
        seconds: 2,
      ),
    );

    pulseAnimation =
        Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(

      CurvedAnimation(
        parent:
            pulseController,

        curve:
            Curves.easeInOut,
      ),
    );

    pulseController.repeat(
      reverse: true,
    );

    liveTimer = Timer.periodic(

      const Duration(
        milliseconds: 500,
      ),

      (_) {

        if (mounted) {

          graphX += 1;

          motionSpots.add(

            FlSpot(
              graphX,
              sensorService
                  .motionIntensity,
            ),
          );

          if (motionSpots.length >
              25) {

            motionSpots.removeAt(0);
          }

          setState(() {});
        }
      },
    );

    loadIncidents();

    sensorService.startMonitoring();

    sensorService.accidentStream.listen(
      (detected) async {

        if (detected &&
            !accidentDetected) {

          accidentDetected = true;

          await addIncident();

          await notificationService
              .showEmergencyNotification();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const SOSAlertScreen(),
            ),
          ).then((_) {

            accidentDetected = false;
          });
        }
      },
    );
  }

  Future<void> loadIncidents() async {

    incidents =
        await historyStorageService
            .loadIncidents();

    setState(() {});
  }

  Future<void> addIncident() async {

    final now = DateTime.now();

    incidents.insert(

      0,

      IncidentModel(
        title:
            "Emergency Accident Alert",

        date:
            "${now.day}/${now.month}/${now.year}",

        time:
            "${now.hour}:${now.minute}",

        latitude: "28.6139",

        longitude: "77.2090",
      ),
    );

    await historyStorageService
        .saveIncidents(incidents);

    setState(() {});
  }

  @override
  void dispose() {

    liveTimer?.cancel();

    pulseController.dispose();

    sensorService.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF0F111A),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        elevation: 0,

        title: const Text(
          "Smart SOS",

          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [

          IconButton(
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const NotificationCenterScreen(),
                ),
              );
            },

            icon: Stack(
              children: [

                const Icon(
                  Icons.notifications,
                ),

                Positioned(
                  right: 0,
                  top: 0,

                  child: Container(
                    width: 10,
                    height: 10,

                    decoration:
                        const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SettingsScreen(),
                ),
              );
            },

            icon: const Icon(
              Icons.settings,
            ),
          ),

          IconButton(
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const ProfileScreen(),
                ),
              );
            },

            icon:
                const Icon(Icons.person),
          ),
        ],
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(24),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 10),

              const Text(
                "Road Safety\nMonitoring System",

                style: TextStyle(
                  fontSize: 34,
                  fontWeight:
                      FontWeight.bold,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 30),

              ScaleTransition(
                scale: pulseAnimation,

                child: Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(
                    24,
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
                      28,
                    ),
                  ),

                  child: const Column(
                    children: [

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Icon(
                            Icons.shield,
                            size: 34,
                            color: Colors.white,
                          ),

                          SizedBox(width: 12),

                          Text(
                            "SYSTEM ACTIVE",

                            style: TextStyle(
                              fontSize: 24,
                              fontWeight:
                                  FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround,

                        children: [

                          Column(
                            children: [

                              Icon(
                                Icons.sensors,
                                color: Colors.white,
                              ),

                              SizedBox(height: 10),

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

                              SizedBox(height: 10),

                              Text(
                                "GPS",
                              ),

                              SizedBox(height: 4),

                              Text(
                                "TRACKING",

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

                              SizedBox(height: 10),

                              Text(
                                "Emergency",
                              ),

                              SizedBox(height: 4),

                              Text(
                                "READY",

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
              ),

              const SizedBox(height: 25),

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

                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding:
                    const EdgeInsets.all(
                  18,
                ),

                decoration: BoxDecoration(
                  color:
                      Colors.green.withValues(
                    alpha: 0.15,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),

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

              const SizedBox(height: 30),

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                  22,
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.sensors,
                          color: Colors.red,
                        ),

                        SizedBox(width: 12),

                        Text(
                          "Live Sensor Activity",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    buildSensorTile(
                      title:
                          "Accelerometer X",

                      value:
                          sensorService
                              .accelerometerX
                              .toStringAsFixed(
                                2,
                              ),

                      color:
                          Colors.red,
                    ),

                    buildSensorTile(
                      title:
                          "Accelerometer Y",

                      value:
                          sensorService
                              .accelerometerY
                              .toStringAsFixed(
                                2,
                              ),

                      color:
                          Colors.orange,
                    ),

                    buildSensorTile(
                      title:
                          "Accelerometer Z",

                      value:
                          sensorService
                              .accelerometerZ
                              .toStringAsFixed(
                                2,
                              ),

                      color:
                          Colors.yellow,
                    ),

                    buildSensorTile(
                      title:
                          "Gyroscope X",

                      value:
                          sensorService
                              .gyroscopeX
                              .toStringAsFixed(
                                2,
                              ),

                      color:
                          Colors.green,
                    ),

                    buildSensorTile(
                      title:
                          "Gyroscope Y",

                      value:
                          sensorService
                              .gyroscopeY
                              .toStringAsFixed(
                                2,
                              ),

                      color:
                          Colors.teal,
                    ),

                    buildSensorTile(
                      title:
                          "Motion Intensity",

                      value:
                          sensorService
                              .motionIntensity
                              .toStringAsFixed(
                                2,
                              ),

                      color:
                          Colors.blue,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                  22,
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.show_chart,
                          color: Colors.red,
                        ),

                        SizedBox(width: 12),

                        Text(
                          "AI Motion Analytics",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      height: 220,

                      child: LineChart(

                        LineChartData(

                          backgroundColor:
                              Colors.transparent,

                          gridData:
                              const FlGridData(
                            show: false,
                          ),

                          titlesData:
                              const FlTitlesData(
                            show: false,
                          ),

                          borderData:
                              FlBorderData(
                            show: false,
                          ),

                          minX:
                              motionSpots
                                      .isEmpty
                                  ? 0
                                  : motionSpots
                                      .first.x,

                          maxX:
                              motionSpots
                                      .isEmpty
                                  ? 25
                                  : motionSpots
                                      .last.x,

                          minY: 0,

                          maxY: 60,

                          lineBarsData: [

                            LineChartBarData(

                              spots:
                                  motionSpots,

                              isCurved: true,

                              color:
                                  Colors.red,

                              barWidth: 4,

                              dotData:
                                  const FlDotData(
                                show: false,
                              ),

                              belowBarData:
                                  BarAreaData(

                                show: true,

                                color: Colors.red
                                    .withValues(
                                  alpha: 0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        buildMiniAnalytics(
                          title:
                              "Current",

                          value:
                              sensorService
                                  .motionIntensity
                                  .toStringAsFixed(
                                    1,
                                  ),

                          color:
                              Colors.red,
                        ),

                        buildMiniAnalytics(
                          title:
                              "Status",

                          value:
                              sensorService
                                          .motionIntensity >
                                      30
                                  ? "HIGH"
                                  : "NORMAL",

                          color:
                              sensorService
                                          .motionIntensity >
                                      30
                                  ? Colors.orange
                                  : Colors.green,
                        ),

                        buildMiniAnalytics(
                          title:
                              "Sensors",

                          value: "LIVE",

                          color:
                              Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 60,

                child:
                    ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue.shade400,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ContactsScreen(),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.contacts,
                  ),

                  label: const Text(
                    "Emergency Contacts",

                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 60,

                child:
                    ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange.shade400,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            HistoryScreen(
                          incidents:
                              incidents,
                        ),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.history,
                  ),

                  label: const Text(
                    "Accident History",

                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                  22,
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.analytics,
                          color: Colors.red,
                        ),

                        SizedBox(width: 12),

                        Text(
                          "Quick Statistics",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceAround,

                      children: [

                        buildStatCard(
                          title:
                              incidents.length
                                  .toString(),

                          subtitle:
                              "Incidents",

                          color:
                              Colors.red,
                        ),

                        buildStatCard(
                          title: "24/7",

                          subtitle:
                              "Monitoring",

                          color:
                              Colors.green,
                        ),

                        buildStatCard(
                          title: "LIVE",

                          subtitle:
                              "Tracking",

                          color:
                              Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 65,

                child:
                    ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red.shade400,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  onPressed: () async {

                    await addIncident();

                    await notificationService
                        .showEmergencyNotification();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const SOSAlertScreen(),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.warning,
                  ),

                  label: const Text(
                    "Simulate Accident",

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatCard({

    required String title,

    required String subtitle,

    required Color color,
  }) {

    return Container(
      width: 90,

      padding:
          const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color:
            color.withValues(
          alpha: 0.12,
        ),

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        border: Border.all(
          color: color,
        ),
      ),

      child: Column(
        children: [

          Text(
            title,

            style: TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            subtitle,

            textAlign:
                TextAlign.center,

            style: const TextStyle(
              color:
                  Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSensorTile({

    required String title,

    required String value,

    required Color color,
  }) {

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 16,
      ),

      padding:
          const EdgeInsets.all(
        18,
      ),

      decoration: BoxDecoration(
        color:
            color.withValues(
          alpha: 0.12,
        ),

        borderRadius:
            BorderRadius.circular(
          18,
        ),

        border: Border.all(
          color: color,
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          Text(
            title,

            style: const TextStyle(
              fontSize: 16,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          Text(
            value,

            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMiniAnalytics({

    required String title,

    required String value,

    required Color color,
  }) {

    return Container(
      width: 95,

      padding:
          const EdgeInsets.all(
        14,
      ),

      decoration: BoxDecoration(
        color:
            color.withValues(
          alpha: 0.12,
        ),

        borderRadius:
            BorderRadius.circular(
          18,
        ),

        border: Border.all(
          color: color,
        ),
      ),

      child: Column(
        children: [

          Text(
            title,

            style: const TextStyle(
              color:
                  Colors.white70,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            value,

            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
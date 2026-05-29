import 'dart:async';
import '../voice_assistant/voice_assistant_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


import '../../models/incident_model.dart';


import '../../services/storage_service/history_storage_service.dart';
import '../../services/sensor_service/sensor_service.dart';
import '../../services/notification_service/notification_service.dart';


import '../emergency_contacts/contact_screen.dart';
import '../history/sos_history_screen.dart';
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
          const Color(0xFF090B12),


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
                  color: Colors.white,
                  size: 28,
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
              color: Colors.white,
              size: 28,
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
                const Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
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


              ShaderMask(


                shaderCallback: (bounds) {


                  return LinearGradient(
                    colors: [


                      Colors.white,


                      Colors.red.shade300,
                    ],
                  ).createShader(bounds);
                },


                child: const Text(
                  "Road Safety\nMonitoring System",


                  style: TextStyle(
                    fontSize: 34,
                    fontWeight:
                        FontWeight.bold,
                    height: 1.2,
                    color: Colors.white,
                  ),
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
                      begin:
                          Alignment.topLeft,


                      end:
                          Alignment
                              .bottomRight,


                      colors: [


                        Colors.red.shade400,


                        const Color(
                          0xFF8A0303,
                        ),
                      ],
                    ),


                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),


                    border: Border.all(
                      color: Colors.red
                          .withValues(
                        alpha: 0.25,
                      ),
                    ),


                    boxShadow: [


                      BoxShadow(
                        color: Colors.red
                            .withValues(
                          alpha: 0.45,
                        ),


                        blurRadius: 30,
                        spreadRadius: 4,


                        offset:
                            const Offset(
                          0,
                          12,
                        ),
                      ),
                    ],
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


                              Text("Sensors"),


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


                              Text("GPS"),


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


                              Text("Emergency"),


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
              )
                  .animate()
                  .fadeIn(
                    duration: 700.ms,
                  )
                  .slideY(
                    begin: 0.3,
                    end: 0,
                  ),


              const SizedBox(height: 25),


              buildGlassCard(
                child: Row(
                  children: [


                    const Icon(
                      Icons.sensors,
                      color: Colors.red,
                      size: 40,
                    ),


                    const SizedBox(width: 15),


                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,


                        children: [


                          const Text(
                            "Live Sensor Monitoring",


                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),


                          const SizedBox(height: 6),


                          Text(
                            "Accelerometer: "
                            "${sensorService.accelerometerX.toStringAsFixed(1)}, "
                            "${sensorService.accelerometerY.toStringAsFixed(1)}, "
                            "${sensorService.accelerometerZ.toStringAsFixed(1)}",


                            style: const TextStyle(
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


              const SizedBox(height: 20),


              buildGlassCard(
                child: Row(
                  children: [


                    const Icon(
                      Icons.rotate_right,
                      color: Colors.orange,
                      size: 40,
                    ),


                    const SizedBox(width: 15),


                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,


                        children: [


                          const Text(
                            "Gyroscope Activity",


                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),


                          const SizedBox(height: 6),


                          Text(
                            "X: ${sensorService.gyroscopeX.toStringAsFixed(1)} | "
                            "Y: ${sensorService.gyroscopeY.toStringAsFixed(1)} | "
                            "Z: ${sensorService.gyroscopeZ.toStringAsFixed(1)}",


                            style: const TextStyle(
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


              const SizedBox(height: 30),


              buildAnalyticsGraph(),


              const SizedBox(height: 35),


              buildGlassCard(
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
                      children: [

                        Expanded(
                          child: buildMiniAnalytics(
                            title: "Incidents",

                            value:
                                incidents.length
                                    .toString(),

                            color: Colors.red,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: buildMiniAnalytics(
                            title: "Tracking",

                            value: "LIVE",

                            color: Colors.blue,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: buildMiniAnalytics(
                            title: "Status",

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
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),


              buildAnimatedButton(
                title:
                    "Emergency Contacts",


                icon:
                    Icons.contacts,


                color:
                    Colors.blue.shade400,


                onTap: () {


                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ContactsScreen(),
                    ),
                  );
                },
              ),


              const SizedBox(height: 20),


              buildAnimatedButton(
                title:
                    "Accident History",


                icon:
                    Icons.history,


                color:
                    Colors.orange.shade400,


                onTap: () {


                  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) =>
        const SOSHistoryScreen(),
  ),
);
                },
              ),


              const SizedBox(height: 20),


              buildAnimatedButton(
              title: "AI Voice Assistant",


              icon: Icons.mic,


              color: Colors.cyan.shade400,


              onTap: () {


                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const VoiceAssistantScreen(),
                  ),
                );
              },
              ),

              const SizedBox(height: 20),

              buildAnimatedButton(
                title: "SOS Alert History",

                icon: Icons.sos,

                color: Colors.red.shade700,

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const SOSHistoryScreen(),
                    ),
                  );
                },
              ),


              const SizedBox(height: 20),


              buildAnimatedButton(
                title:
                    "Notification Center",


                icon:
                    Icons.notifications_active,


                color:
                    Colors.purple.shade400,


                onTap: () {


                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const NotificationCenterScreen(),
                    ),
                  );
                },
              ),


              const SizedBox(height: 40),


              buildAnimatedButton(
                title:
                    "Simulate Accident",


                icon:
                    Icons.warning,


                color:
                    Colors.red.shade400,


                height: 65,


                onTap: () async {


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
              ),


              const SizedBox(height: 20),
               ],
          ),
        ),
      ),
    );
  }

  
Widget buildAnalyticsGraph() {

  return buildGlassCard(

    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Row(
          children: [

            Expanded(
              child: Row(
                children: [

                  const Icon(
                    Icons.show_chart,
                    color: Colors.red,
                    size: 30,
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      "AI Motion Analytics",
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),

              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.red),
              ),

              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.red,
                  ),

                  SizedBox(width: 6),

                  Text(
                    "LIVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 25),

        Container(

          padding:
              const EdgeInsets.all(
            14,
          ),

          decoration: BoxDecoration(

            borderRadius:
                BorderRadius.circular(
              28,
            ),

            gradient: LinearGradient(

              begin:
                  Alignment.topLeft,

              end:
                  Alignment.bottomRight,

              colors: [

                Colors.red.withValues(
                  alpha: 0.10,
                ),

                Colors.black,
              ],
            ),

            border: Border.all(

              color: Colors.red
                  .withValues(
                alpha: 0.35,
              ),
            ),

            boxShadow: [

              BoxShadow(

                color: Colors.red
                    .withValues(
                  alpha: 0.12,
                ),

                blurRadius: 18,
                spreadRadius: 1,
              ),
            ],
          ),

          child: SizedBox(

            height: 240,

            child: LineChart(

              LineChartData(

                backgroundColor:
                    Colors.transparent,

                minX:
                    motionSpots.isEmpty
                        ? 0
                        : motionSpots.first.x,

                maxX:
                    motionSpots.isEmpty
                        ? 25
                        : motionSpots.last.x,

                minY: 0,
                maxY: 60,

                gridData: FlGridData(

                  show: true,

                  drawVerticalLine:
                      true,

                  horizontalInterval:
                      15,

                  verticalInterval:
                      5,

                  getDrawingHorizontalLine:
                      (value) {

                    return FlLine(

                      color: Colors.white
                          .withValues(
                        alpha: 0.10,
                      ),

                      strokeWidth: 1,
                    );
                  },

                  getDrawingVerticalLine:
                      (value) {

                    return FlLine(

                      color: Colors.white
                          .withValues(
                        alpha: 0.05,
                      ),

                      strokeWidth: 1,
                    );
                  },
                ),

                titlesData:
                    FlTitlesData(

                  leftTitles:
                      AxisTitles(

                    sideTitles:
                        SideTitles(

                      showTitles:
                          true,

                      reservedSize:
                          32,

                      getTitlesWidget:
                          (
                        value,
                        meta,
                      ) {

                        return Text(

                          value
                              .toInt()
                              .toString(),

                          style:
                              const TextStyle(
                            color:
                                Colors.white54,

                            fontSize:
                                11,
                          ),
                        );
                      },
                    ),
                  ),

                  bottomTitles:
                      AxisTitles(

                    sideTitles:
                        SideTitles(

                      showTitles:
                          true,

                      interval: 5,

                      getTitlesWidget:
                          (
                        value,
                        meta,
                      ) {

                        return Padding(

                          padding:
                              const EdgeInsets.only(
                            top: 8,
                          ),

                          child: Text(

                            "00:${value.toInt()}",

                            style:
                                const TextStyle(
                              color:
                                  Colors.white54,

                              fontSize:
                                  10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  topTitles:
                      const AxisTitles(
                    sideTitles:
                        SideTitles(
                      showTitles:
                          false,
                    ),
                  ),

                  rightTitles:
                      const AxisTitles(
                    sideTitles:
                        SideTitles(
                      showTitles:
                          false,
                    ),
                  ),
                ),

                borderData:
                    FlBorderData(

                  show: true,

                  border: Border.all(

                    color: Colors.red
                        .withValues(
                      alpha: 0.15,
                    ),
                  ),
                ),

                lineBarsData: [

                  LineChartBarData(

                    spots:
                        motionSpots,

                    isCurved: true,

                    curveSmoothness:
                        0.35,

                    color:
                        Colors.redAccent,

                    barWidth: 4,

                    isStrokeCapRound:
                        true,

                    dotData:
                        FlDotData(

                      show: true,

                      getDotPainter:
                          (
                        spot,
                        percent,
                        barData,
                        index,
                      ) {

                        return FlDotCirclePainter(

                          radius: 5,

                          color:
                              Colors.white,

                          strokeWidth:
                              3,

                          strokeColor:
                              Colors.redAccent,
                        );
                      },
                    ),

                    belowBarData:
                        BarAreaData(

                      show: true,

                      gradient:
                          LinearGradient(

                        begin:
                            Alignment.topCenter,

                        end:
                            Alignment.bottomCenter,

                        colors: [

                          Colors.redAccent
                              .withValues(
                            alpha: 0.35,
                          ),

                          Colors.redAccent
                              .withValues(
                            alpha: 0.02,
                          ),
                        ],
                      ),
                    ),

                    shadow: Shadow(

                      color: Colors.red
                          .withValues(
                        alpha: 0.7,
                      ),

                      blurRadius:
                          14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 22),

        Row(
          children: [

            Expanded(
              child: buildMiniAnalytics(
                title: "Current",

                value: sensorService
                    .motionIntensity
                    .toStringAsFixed(1),

                color: Colors.red,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: buildMiniAnalytics(
                title: "Status",

                value: sensorService
                            .motionIntensity >
                        30
                    ? "HIGH"
                    : "NORMAL",

                color: sensorService
                            .motionIntensity >
                        30
                    ? Colors.orange
                    : Colors.green,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: buildMiniAnalytics(
                title: "Sensors",

                value: "LIVE",

                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

  // ─── UPDATED buildGlassCard ───────────────────────────────────────────────


  Widget buildGlassCard({
    required Widget child,
  }) {


    return Container(
      width: double.infinity,


      padding: const EdgeInsets.all(22),


      decoration: BoxDecoration(


        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,


          colors: [


            Colors.white.withValues(
              alpha: 0.08,
            ),


            const Color(0xFF141824),


            const Color(0xFF0A0D14),
          ],
        ),


        borderRadius:
            BorderRadius.circular(
         28,
        ),


        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.08,
          ),
        ),


        boxShadow: [


          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.45,
            ),


            blurRadius: 24,
            spreadRadius: 2,


            offset: const Offset(
              0,
              12,
            ),
          ),


          BoxShadow(
            color: Colors.red.withValues(
              alpha: 0.08,
            ),


            blurRadius: 24,
            spreadRadius: 1,
          ),
        ],
      ),


      child: child,
    )
        .animate()
        .fadeIn(
          duration: 700.ms,
        )
        .slideY(
          begin: 0.15,
        )
        .scale(
          begin: const Offset(
            0.98,
            0.98,
          ),


          end: const Offset(
            1,
            1,
          ),
        );
  }


  // ─── UPDATED buildAnimatedButton ─────────────────────────────────────────


  Widget buildAnimatedButton({


    required String title,


    required IconData icon,


    required Color color,


    required VoidCallback onTap,


    double height = 60,
  }) {


    return Container(


      decoration: BoxDecoration(


        borderRadius:
            BorderRadius.circular(
         22,
        ),


        boxShadow: [


          BoxShadow(
            color: color.withValues(
              alpha: 0.35,
            ),


            blurRadius: 28,
            spreadRadius: 2,
          ),
        ],
      ),


      child: SizedBox(
        width: double.infinity,
        height: height,


        child:
            ElevatedButton.icon(


          style:
              ElevatedButton.styleFrom(


            backgroundColor:
                color.withValues(
              alpha: 0.92,
            ),


            elevation: 0,


            shadowColor:
                Colors.transparent,


            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                22,
              ),
            ),
          ),


          onPressed: onTap,


          icon: Icon(
            icon,
            size: 24,
          ),


          label: Text(
            title,


            style: const TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,


              letterSpacing: 0.4,
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 700.ms,
        )
        .slideY(
          begin: 0.2,
        )
        .shimmer(
          duration: 2200.ms,
          delay: 1200.ms,
        );
  }


  // ─── UPDATED buildMiniAnalytics ──────────────────────────────────────────


  Widget buildMiniAnalytics({


    required String title,


    required String value,


    required Color color,
  }) {


    return Container(
      constraints: const BoxConstraints(
        minWidth: 90,
        maxWidth: 110,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(


        gradient: LinearGradient(


          begin: Alignment.topLeft,
          end: Alignment.bottomRight,


          colors: [


            color.withValues(
              alpha: 0.22,
            ),


            color.withValues(
              alpha: 0.05,
            ),
          ],
        ),


        borderRadius:
            BorderRadius.circular(
         24,
        ),


        border: Border.all(
          color: color.withValues(
            alpha: 0.8,
          ),
        ),


        boxShadow: [


          BoxShadow(
            color: color.withValues(
              alpha: 0.18,
            ),


            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),


      child: Column(
        children: [


          Text(
            title,


            style: const TextStyle(
              color:
                  Colors.white70,


              fontSize: 14,
            ),
          ),


          const SizedBox(height: 12),


          Text(
            value,


            textAlign:
                TextAlign.center,


            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    )
        .animate()
        .scale(
          duration: 500.ms,
        )
        .fadeIn();
  }
}
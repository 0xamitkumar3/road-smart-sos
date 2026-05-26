import 'package:flutter/material.dart';

class SettingsScreen
    extends StatefulWidget {

  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  bool notificationsEnabled = true;

  bool autoSOS = true;

  bool gpsTracking = true;

  bool emergencySound = true;

  bool vibrationAlert = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF0F111A),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        title: const Text(
          "Settings",
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Emergency Settings",

              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            buildSwitchTile(
              title:
                  "Notifications",

              subtitle:
                  "Enable emergency notifications",

              value:
                  notificationsEnabled,

              icon:
                  Icons.notifications_active,

              onChanged: (value) {

                setState(() {

                  notificationsEnabled =
                      value;
                });
              },
            ),

            buildSwitchTile(
              title: "Auto SOS",

              subtitle:
                  "Automatically trigger SOS",

              value: autoSOS,

              icon: Icons.warning,

              onChanged: (value) {

                setState(() {

                  autoSOS = value;
                });
              },
            ),

            buildSwitchTile(
              title:
                  "GPS Tracking",

              subtitle:
                  "Enable live location tracking",

              value: gpsTracking,

              icon: Icons.gps_fixed,

              onChanged: (value) {

                setState(() {

                  gpsTracking =
                      value;
                });
              },
            ),

            buildSwitchTile(
              title:
                  "Emergency Sound",

              subtitle:
                  "Play alert sound during SOS",

              value:
                  emergencySound,

              icon: Icons.volume_up,

              onChanged: (value) {

                setState(() {

                  emergencySound =
                      value;
                });
              },
            ),

            buildSwitchTile(
              title:
                  "Vibration Alert",

              subtitle:
                  "Enable emergency vibration",

              value:
                  vibrationAlert,

              icon:
                  Icons.vibration,

              onChanged: (value) {

                setState(() {

                  vibrationAlert =
                      value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSwitchTile({

    required String title,

    required String subtitle,

    required bool value,

    required IconData icon,

    required Function(bool)
        onChanged,
  }) {

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 20,
      ),

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color:
            const Color(0xFF1C1F2E),

        borderRadius:
            BorderRadius.circular(
          24,
        ),
      ),

      child: Row(
        children: [

          CircleAvatar(
            backgroundColor:
                Colors.red.shade400,

            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(
                  title,

                  style:
                      const TextStyle(
                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,

                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,

            activeThumbColor:
                Colors.red.shade400,

            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
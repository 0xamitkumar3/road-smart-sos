import 'package:flutter/material.dart';

class NotificationCenterScreen
    extends StatelessWidget {

  const NotificationCenterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final notifications = [

      {
        "title":
            "Emergency SOS Triggered",

        "time":
            "2 mins ago",

        "icon":
            Icons.warning,

        "color":
            Colors.red,
      },

      {
        "title":
            "GPS Tracking Active",

        "time":
            "5 mins ago",

        "icon":
            Icons.gps_fixed,

        "color":
            Colors.green,
      },

      {
        "title":
            "Nearby Hospital Alerted",

        "time":
            "10 mins ago",

        "icon":
            Icons.local_hospital,

        "color":
            Colors.blue,
      },

      {
        "title":
            "Police Station Notified",

        "time":
            "12 mins ago",

        "icon":
            Icons.local_police,

        "color":
            Colors.orange,
      },
    ];

    return Scaffold(
      backgroundColor:
          const Color(0xFF0F111A),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        title: const Text(
          "Notification Center",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Recent Emergency Alerts",

              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView.builder(

                itemCount:
                    notifications.length,

                itemBuilder:
                    (context, index) {

                  final notification =
                      notifications[index];

                  return Container(
                    margin:
                        const EdgeInsets.only(
                      bottom: 18,
                    ),

                    padding:
                        const EdgeInsets.all(
                      18,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFF1C1F2E,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        24,
                      ),
                    ),

                    child: Row(
                      children: [

                        CircleAvatar(
                          radius: 28,

                          backgroundColor:
                              (notification["color"]
                                      as Color)
                                  .withValues(
                            alpha: 0.2,
                          ),

                          child: Icon(
                            notification["icon"]
                                as IconData,

                            color:
                                notification["color"]
                                    as Color,
                          ),
                        ),

                        const SizedBox(
                          width: 18,
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                notification["title"]
                                    as String,

                                style:
                                    const TextStyle(
                                  fontSize:
                                      18,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                height: 6,
                              ),

                              Text(
                                notification["time"]
                                    as String,

                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios,
                          color:
                              Colors.white54,

                          size: 16,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
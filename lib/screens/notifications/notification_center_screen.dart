import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotificationCenterScreen
    extends StatefulWidget {

  const NotificationCenterScreen({
    super.key,
  });

  @override
  State<NotificationCenterScreen>
      createState() =>
          _NotificationCenterScreenState();
}

class _NotificationCenterScreenState
    extends State<
        NotificationCenterScreen> {

  List<Map<String, dynamic>>
      notifications = [

    {
      "title":
          "Emergency SOS Triggered",

      "time":
          "2 mins ago",

      "icon":
          Icons.warning_rounded,

      "color":
          Colors.redAccent,

      "category":
          "Emergency",

      "read":
          false,
    },

    {
      "title":
          "GPS Tracking Active",

      "time":
          "5 mins ago",

      "icon":
          Icons.gps_fixed,

      "color":
          Colors.greenAccent,

      "category":
          "System",

      "read":
          true,
    },

    {
      "title":
          "Nearby Hospital Alerted",

      "time":
          "10 mins ago",

      "icon":
          Icons.local_hospital,

      "color":
          Colors.blueAccent,

      "category":
          "Medical",

      "read":
          false,
    },

    {
      "title":
          "Police Station Notified",

      "time":
          "12 mins ago",

      "icon":
          Icons.local_police,

      "color":
          Colors.orangeAccent,

      "category":
          "Security",

      "read":
          true,
    },

    {
      "title":
          "AI Motion Spike Detected",

      "time":
          "18 mins ago",

      "icon":
          Icons.analytics,

      "color":
          Colors.purpleAccent,

      "category":
          "AI Detection",

      "read":
          false,
    },
  ];

  @override
  Widget build(BuildContext context) {

    final unreadCount =
        notifications
            .where(
              (n) =>
                  n["read"] ==
                  false,
            )
            .length;

    return Scaffold(
      backgroundColor:
          const Color(0xFF090B12),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        elevation: 0,

        title: const Text(
          "Notification Center",

          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [

          IconButton(
            onPressed: () {

              setState(() {

                for (var n
                    in notifications) {

                  n["read"] = true;
                }
              });
            },

            icon: const Icon(
              Icons.done_all,
            ),
          ),
        ],
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                24,
              ),

              decoration:
                  BoxDecoration(

                gradient:
                    LinearGradient(
                  begin:
                      Alignment.topLeft,

                  end:
                      Alignment
                          .bottomRight,

                  colors: [

                    Colors.red
                        .withValues(
                      alpha: 0.18,
                    ),

                    Colors.purple
                        .withValues(
                      alpha: 0.08,
                    ),

                    const Color(
                      0xFF141824,
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
                    alpha: 0.15,
                  ),
                ),

                boxShadow: [

                  BoxShadow(
                    color: Colors.red
                        .withValues(
                      alpha: 0.15,
                    ),

                    blurRadius: 25,
                    spreadRadius: 1,
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Row(
                    children: [

                      Icon(
                        Icons
                            .notifications_active,
                        color:
                            Colors.red,
                        size: 34,
                      ),

                      SizedBox(width: 14),

                      Text(
                        "Emergency Alerts",

                        style: TextStyle(
                          fontSize: 26,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  Text(
                    "$unreadCount unread notifications",

                    style: const TextStyle(
                      color:
                          Colors.white70,

                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  Row(
                    children: [

                      buildTopStat(
                        title:
                            "TOTAL",

                        value:
                            notifications
                                .length
                                .toString(),

                        color:
                            Colors.blue,
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      buildTopStat(
                        title:
                            "UNREAD",

                        value:
                            unreadCount
                                .toString(),

                        color:
                            Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(
                  duration: 700.ms,
                )
                .slideY(
                  begin: 0.2,
                ),

            const SizedBox(height: 28),

            const Text(
              "Recent Activity",

              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(

                itemCount:
                    notifications.length,

                itemBuilder:
                    (context, index) {

                  final notification =
                      notifications[index];

                  final isRead =
                      notification["read"]
                          as bool;

                  final Color color =
                      notification["color"]
                          as Color;

                  return Dismissible(

                    key: Key(
                      notification["title"]
                          as String,
                    ),

                    direction:
                        DismissDirection
                            .endToStart,

                    onDismissed:
                        (_) {

                      setState(() {

                        notifications
                            .removeAt(
                          index,
                        );
                      });

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(

                        const SnackBar(
                          content: Text(
                            "Notification deleted",
                          ),
                        ),
                      );
                    },

                    background:
                        Container(

                      margin:
                          const EdgeInsets.only(
                        bottom: 18,
                      ),

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),

                      alignment:
                          Alignment
                              .centerRight,

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.red,

                        borderRadius:
                            BorderRadius.circular(
                          28,
                        ),
                      ),

                      child: const Icon(
                        Icons.delete,
                        color:
                            Colors.white,
                        size: 30,
                      ),
                    ),

                    child: GestureDetector(

                      onTap: () {

                        setState(() {

                          notification["read"] =
                              true;
                        });
                      },

                      child: Container(

                        margin:
                            const EdgeInsets.only(
                          bottom: 18,
                        ),

                        padding:
                            const EdgeInsets.all(
                          20,
                        ),

                        decoration:
                            BoxDecoration(

                          gradient:
                              LinearGradient(

                            begin:
                                Alignment
                                    .topLeft,

                            end:
                                Alignment
                                    .bottomRight,

                            colors: [

                              color.withValues(
                                alpha:
                                    isRead
                                        ? 0.08
                                        : 0.20,
                              ),

                              const Color(
                                0xFF141824,
                              ),
                            ],
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            28,
                          ),

                          border: Border.all(

                            color:
                                color.withValues(
                              alpha:
                                  isRead
                                      ? 0.15
                                      : 0.6,
                            ),
                          ),

                          boxShadow: [

                            BoxShadow(

                              color:
                                  color.withValues(
                                alpha:
                                    isRead
                                        ? 0.05
                                        : 0.22,
                              ),

                              blurRadius:
                                  20,

                              spreadRadius:
                                  1,
                            ),
                          ],
                        ),

                        child: Row(
                          children: [

                            Container(
                              padding:
                                  const EdgeInsets.all(
                                16,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    color.withValues(
                                  alpha:
                                      0.18,
                                ),

                                shape:
                                    BoxShape.circle,
                              ),

                              child: Icon(

                                notification["icon"]
                                    as IconData,

                                color: color,
                                size: 30,
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

                                  Row(
                                    children: [

                                      Expanded(
                                        child: Text(

                                          notification["title"]
                                              as String,

                                          style:
                                              TextStyle(

                                            fontSize:
                                                18,

                                            fontWeight:
                                                FontWeight.bold,

                                            color:
                                                isRead
                                                    ? Colors.white70
                                                    : Colors.white,
                                          ),
                                        ),
                                      ),

                                      if (!isRead)

                                        Container(
                                          width: 10,
                                          height: 10,

                                          decoration:
                                              BoxDecoration(
                                            color:
                                                color,

                                            shape:
                                                BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [

                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal:
                                              12,

                                          vertical:
                                              6,
                                        ),

                                        decoration:
                                            BoxDecoration(

                                          color:
                                              color.withValues(
                                            alpha:
                                                0.15,
                                          ),

                                          borderRadius:
                                              BorderRadius.circular(
                                            20,
                                          ),
                                        ),

                                        child: Text(

                                          notification["category"]
                                              as String,

                                          style:
                                              TextStyle(
                                            color:
                                                color,

                                            fontWeight:
                                                FontWeight.bold,

                                            fontSize:
                                                12,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 12,
                                      ),

                                      Text(

                                        notification["time"]
                                            as String,

                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.white54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            const Icon(
                              Icons
                                  .arrow_forward_ios,

                              color:
                                  Colors.white38,

                              size: 16,
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(
                            duration:
                                600.ms,
                          )
                          .slideX(
                            begin: 0.1,
                          ),
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

  Widget buildTopStat({

    required String title,

    required String value,

    required Color color,
  }) {

    return Expanded(
      child: Container(

        padding:
            const EdgeInsets.all(
          16,
        ),

        decoration:
            BoxDecoration(

          gradient:
              LinearGradient(

            colors: [

              color.withValues(
                alpha: 0.22,
              ),

              color.withValues(
                alpha: 0.06,
              ),
            ],
          ),

          borderRadius:
              BorderRadius.circular(
            22,
          ),

          border: Border.all(
            color: color.withValues(
              alpha: 0.4,
            ),
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

            const SizedBox(
              height: 10,
            ),

            Text(
              value,

              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
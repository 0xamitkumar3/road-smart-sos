import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'sos_location_screen.dart';

class SOSHistoryScreen extends StatelessWidget {
  const SOSHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B12),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "SOS Alert History",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            tooltip: "Delete All History",

            icon: const Icon(
              Icons.delete_sweep,
              color: Colors.red,
            ),

            onPressed: () {
              showDialog(
                context: context,

                builder: (_) => AlertDialog(
                  title: const Text(
                    "Delete History?",
                  ),

                  content: const Text(
                    "This action cannot be undone.\n\nAll SOS records will be permanently removed.",
                  ),

                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context),

                      child: const Text(
                        "Cancel",
                      ),
                    ),

                    TextButton(
                      onPressed: () async {
                        final snapshot =
                            await FirebaseFirestore
                                .instance
                                .collection(
                                  "sos_alerts",
                                )
                                .get();

                        for (var doc
                            in snapshot.docs) {
                          await doc.reference
                              .delete();
                        }

                        if (context.mounted) {
                          Navigator.pop(
                            context,
                          );

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            const SnackBar(
                              backgroundColor:
                                  Colors.red,

                              content: Text(
                                "SOS History Deleted Successfully",
                              ),
                            ),
                          );
                        }
                      },

                      child: const Text(
                        "Delete",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore
            .instance
            .collection("sos_alerts")
            .orderBy(
              "createdAt",
              descending: true,
            )
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.history,
                    size: 100,
                    color: Colors.white30,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    "No SOS Alerts Found",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          final alerts =
              snapshot.data!.docs;

          return Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.all(
                  20,
                ),

                padding:
                    const EdgeInsets.all(
                  20,
                ),

                decoration:
                    BoxDecoration(
                  color: Colors.red
                      .withValues(
                    alpha: 0.15,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 40,
                    ),

                    const SizedBox(
                      width: 16,
                    ),

                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [
                        const Text(
                          "Total SOS Alerts",
                          style:
                              TextStyle(
                            color:
                                Colors.white70,
                          ),
                        ),

                        Text(
                          alerts.length
                              .toString(),

                          style:
                              const TextStyle(
                            color:
                                Colors.white,

                            fontSize:
                                28,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child:
                    ListView.builder(
                  itemCount:
                      alerts.length,

                  itemBuilder:
                      (context, index) {
                    final data =
                        alerts[index]
                                .data()
                            as Map<String,
                                dynamic>;

                    final timestamp =
                        data["createdAt"];

                    String date =
                        "Unknown";

                    if (timestamp
                        is Timestamp) {
                      final dt =
                          timestamp
                              .toDate();

                      date =
                          "${dt.day}/${dt.month}/${dt.year}  ${dt.hour}:${dt.minute}";
                    }

                    return Container(
                      margin:
                          const EdgeInsets.symmetric(
                        horizontal:
                            20,
                        vertical: 10,
                      ),

                      padding:
                          const EdgeInsets.all(
                        18,
                      ),

                      decoration:
                          BoxDecoration(
                        color: Colors
                            .white
                            .withValues(
                          alpha: 0.05,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          24,
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.all(
                                  10,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color: Colors
                                      .red
                                      .withValues(
                                    alpha:
                                        0.15,
                                  ),

                                  shape:
                                      BoxShape.circle,
                                ),

                                child:
                                    const Icon(
                                  Icons.sos,
                                  color:
                                      Colors.red,
                                ),
                              ),

                              const SizedBox(
                                width: 12,
                              ),

                              Expanded(
                                child: Text(
                                  data["email"] ??
                                      "Unknown",

                                  style:
                                      const TextStyle(
                                    color:
                                        Colors.white,

                                    fontWeight:
                                        FontWeight.bold,

                                    fontSize:
                                        16,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 14,
                          ),

                          Text(
                            "Latitude: ${data["latitude"]}",
                            style:
                                const TextStyle(
                              color:
                                  Colors.white70,
                            ),
                          ),

                          Text(
                            "Longitude: ${data["longitude"]}",
                            style:
                                const TextStyle(
                              color:
                                  Colors.white70,
                            ),
                          ),

                          Text(
                            "Status: ${data["status"]}",
                            style:
                                const TextStyle(
                              color:
                                  Colors.green,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            date,
                            style:
                                const TextStyle(
                              color:
                                  Colors.white54,
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          SizedBox(
                            width:
                                double.infinity,

                            child:
                                ElevatedButton.icon(
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.red,

                                foregroundColor:
                                    Colors.white,

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    14,
                                  ),
                                ),
                              ),

                              onPressed:
                                  () {
                                Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            SOSLocationScreen(
                                      latitude:
                                          (data["latitude"]
                                                  as num)
                                              .toDouble(),

                                      longitude:
                                          (data["longitude"]
                                                  as num)
                                              .toDouble(),
                                    ),
                                  ),
                                );
                              },

                              icon:
                                  const Icon(
                                Icons
                                    .location_on,
                              ),

                              label:
                                  const Text(
                                "View Location",
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../models/incident_model.dart';

class HistoryScreen extends StatelessWidget {

  final List<IncidentModel> incidents;

  const HistoryScreen({
    super.key,
    required this.incidents,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF0F111A),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        title: const Text(
          "Accident History",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: incidents.isEmpty

            ? const Center(
                child: Text(
                  "No incidents recorded yet.",

                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              )

            : ListView.builder(

                itemCount:
                    incidents.length,

                itemBuilder:
                    (context, index) {

                  final incident =
                      incidents[index];

                  return Container(
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
                      color:
                          const Color(
                        0xFF1C1F2E,
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

                            Icon(
                              Icons.warning,
                              color: Colors
                                  .red.shade400,
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Expanded(
                              child: Text(
                                incident.title,

                                style:
                                    const TextStyle(
                                  fontSize:
                                      20,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Text(
                          "Date: ${incident.date}",
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          "Time: ${incident.time}",
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          "Latitude: ${incident.latitude}",
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          "Longitude: ${incident.longitude}",
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
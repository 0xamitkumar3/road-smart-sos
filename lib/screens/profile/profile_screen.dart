import 'package:flutter/material.dart';

import '../medical/medical_info_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: const Text(
          "Profile",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 20),

              CircleAvatar(
                radius: 55,

                backgroundColor:
                    Colors.red.shade400,

                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Amit Kumar",

                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "imamit0311@gmail.com",

                style: TextStyle(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 40),

              buildTile(
                Icons.phone,
                "Emergency Contacts",
              ),

              buildTile(
                Icons.bloodtype,
                "Blood Group: O+",
              ),

              buildTile(
                Icons.directions_car,
                "Vehicle: Car",
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 60,

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

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const MedicalInfoScreen(),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.health_and_safety,
                  ),

                  label: const Text(
                    "Medical Information",

                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTile(
    IconData icon,
    String text,
  ) {

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
          18,
        ),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color:
                Colors.red.shade400,
          ),

          const SizedBox(width: 15),

          Text(
            text,

            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
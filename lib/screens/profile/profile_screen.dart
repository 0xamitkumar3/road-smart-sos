import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../services/auth_service.dart';

import '../auth/login_screen.dart';
import '../medical/medical_info_screen.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF090B12),

      appBar: AppBar(

        backgroundColor:
            Colors.transparent,

        elevation: 0,

        centerTitle: true,

        title: const Text(

          "My Profile",

          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          physics:
              const BouncingScrollPhysics(),

          padding:
              const EdgeInsets.all(
            24,
          ),

          child: Column(
            children: [

              const SizedBox(
                height: 10,
              ),

              Container(

                width: 130,
                height: 130,

                decoration:
                    BoxDecoration(

                  shape:
                      BoxShape.circle,

                  gradient:
                      LinearGradient(

                    colors: [

                      Colors.red.shade400,

                      Colors.red.shade900,
                    ],
                  ),

                  boxShadow: [

                    BoxShadow(

                      color: Colors.red
                          .withValues(
                        alpha: 0.4,
                      ),

                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.white,
                ),
              )
                  .animate()
                  .scale(
                    duration: 700.ms,
                  )
                  .fadeIn(),

              const SizedBox(
                height: 24,
              ),

              const Text(

                "Amit Kumar",

                style: TextStyle(
                  fontSize: 30,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      Colors.white,
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: 200.ms,
                  ),

              const SizedBox(
                height: 8,
              ),

              Text(

                "imamit0311@gmail.com",

                style: TextStyle(
                  color:
                      Colors.grey.shade400,

                  fontSize: 16,
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: 350.ms,
                  ),

              const SizedBox(
                height: 40,
              ),

              buildGlassTile(
                icon:
                    Icons.phone,

                title:
                    "Emergency Contacts",

                subtitle:
                    "3 Contacts Added",
              ),

              buildGlassTile(
                icon:
                    Icons.bloodtype,

                title:
                    "Blood Group",

                subtitle:
                    "O+ Positive",
              ),

              buildGlassTile(
                icon:
                    Icons.location_on,

                title:
                    "Live Tracking",

                subtitle:
                    "Enabled",
              ),

              buildGlassTile(
                icon:
                    Icons.shield,

                title:
                    "Safety Status",

                subtitle:
                    "Protected",
              ),

              const SizedBox(
                height: 30,
              ),

              buildMainButton(

                text:
                    "Medical Information",

                icon:
                    Icons.health_and_safety,

                color:
                    Colors.red,

                onTap: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                          const MedicalInfoScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 18,
              ),

              buildMainButton(

                text:
                    "Logout",

                icon:
                    Icons.logout,

                color:
                    Colors.red.shade800,

                onTap: () async {

                  await AuthService()
                      .logout();

                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                          const LoginScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGlassTile({

    required IconData icon,

    required String title,

    required String subtitle,
  }) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      padding:
          const EdgeInsets.all(
        20,
      ),

      decoration: BoxDecoration(

        gradient:
            LinearGradient(

          begin:
              Alignment.topLeft,

          end:
              Alignment.bottomRight,

          colors: [

            Colors.white
                .withValues(
              alpha: 0.05,
            ),

            const Color(
              0xFF151925,
            ),
          ],
        ),

        borderRadius:
            BorderRadius.circular(
          24,
        ),

        border: Border.all(

          color:
              Colors.white
                  .withValues(
            alpha: 0.08,
          ),
        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.red
                    .withValues(
              alpha: 0.06,
            ),

            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),

      child: Row(
        children: [

          Container(

            padding:
                const EdgeInsets.all(
              14,
            ),

            decoration:
                BoxDecoration(

              color:
                  Colors.red
                      .withValues(
                alpha: 0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                16,
              ),
            ),

            child: Icon(
              icon,
              color:
                  Colors.red.shade300,
              size: 28,
            ),
          ),

          const SizedBox(
            width: 18,
          ),

          Expanded(
            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: const TextStyle(
                    color:
                        Colors.white,

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(

                  subtitle,

                  style: TextStyle(
                    color:
                        Colors.grey.shade400,

                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.arrow_forward_ios,
            color:
                Colors.grey.shade600,
            size: 18,
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          duration: 600.ms,
        )
        .slideY(
          begin: 0.15,
        );
  }

  Widget buildMainButton({

    required String text,

    required IconData icon,

    required Color color,

    required VoidCallback onTap,
  }) {

    return SizedBox(

      width: double.infinity,
      height: 62,

      child: ElevatedButton.icon(

        style:
            ElevatedButton.styleFrom(

          backgroundColor:
              color,

          elevation: 0,

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

          text,

          style: const TextStyle(
            fontSize: 18,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: 300.ms,
        )
        .slideY(
          begin: 0.15,
        );
  }
}
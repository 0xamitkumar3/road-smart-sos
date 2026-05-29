import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';

import '../home/home_screen.dart';

class SignupScreen extends StatefulWidget {

  const SignupScreen({
    super.key,
  });

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {

  bool otpSent = false;

  final TextEditingController
      nameController =
          TextEditingController();

  final TextEditingController
      phoneController =
          TextEditingController();

  final TextEditingController
      otpController =
          TextEditingController();

  final TextEditingController
      emailController =
          TextEditingController();

  final TextEditingController
      passwordController =
          TextEditingController();

  final TextEditingController
      bloodGroupController =
          TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF090B12),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,

        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          physics:
              const BouncingScrollPhysics(),

          child: Padding(
            padding:
                const EdgeInsets.all(
              24,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Align(
                  alignment:
                      Alignment.topRight,

                  child: Container(
                    width: 130,
                    height: 130,

                    decoration:
                        BoxDecoration(

                      shape:
                          BoxShape.circle,

                      gradient:
                          RadialGradient(

                        colors: [

                          Colors.red
                              .withValues(
                            alpha: 0.22,
                          ),

                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                ShaderMask(

                  shaderCallback:
                      (bounds) {

                    return LinearGradient(
                      colors: [

                        Colors.white,

                        Colors.red
                            .shade300,
                      ],
                    ).createShader(
                      bounds,
                    );
                  },

                  child: const Text(
                    "Create Account",

                    style: TextStyle(
                      fontSize: 40,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Colors.white,
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(
                      duration: 700.ms,
                    )
                    .slideY(
                      begin: 0.2,
                    ),

                const SizedBox(
                  height: 14,
                ),

                const Text(
                  "Join the futuristic\nAI-powered emergency platform",

                  style: TextStyle(
                    color:
                        Colors.white70,

                    fontSize: 17,
                    height: 1.5,
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: 300.ms,
                    ),

                const SizedBox(
                  height: 45,
                ),

                buildGlassCard(

                  child: Column(
                    children: [

                      const Row(
                        children: [

                          Icon(
                            Icons.person_add,
                            color:
                                Colors.red,
                          ),

                          SizedBox(
                            width: 12,
                          ),

                          Text(
                            "User Registration",

                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      CustomTextField(
                        hint:
                            "Full Name",

                        icon:
                            Icons.person,

                        controller:
                            nameController,
                      ),

                      const SizedBox(
                        height: 22,
                      ),

                      CustomTextField(
                        hint:
                            "Phone Number",

                        icon:
                            Icons.phone_android,

                        controller:
                            phoneController,
                      ),

                      const SizedBox(
                        height: 22,
                      ),

                      if (!otpSent)

                        SizedBox(
                          width:
                              double.infinity,

                          child:
                              ElevatedButton.icon(

                            style:
                                ElevatedButton.styleFrom(

                              backgroundColor:
                                  Colors.blueAccent,

                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 16,
                              ),

                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  18,
                                ),
                              ),
                            ),

                            onPressed: () {

                              setState(() {

                                otpSent =
                                    true;
                              });

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(

                                const SnackBar(
                                  content: Text(
                                    "OTP Sent Successfully",
                                  ),
                                ),
                              );
                            },

                            icon: const Icon(
                              Icons.sms,
                            ),

                            label: const Text(
                              "Send OTP",
                            ),
                          ),
                        ),

                      if (otpSent) ...[

                        const SizedBox(
                          height: 22,
                        ),

                        CustomTextField(
                          hint:
                              "Enter OTP",

                          icon:
                              Icons.password,

                          controller:
                              otpController,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Align(
                          alignment:
                              Alignment.centerRight,

                          child: TextButton(
                            onPressed: () {

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(

                                const SnackBar(
                                  content: Text(
                                    "OTP Resent",
                                  ),
                                ),
                              );
                            },

                            child: Text(
                              "Resend OTP",

                              style: TextStyle(
                                color: Colors
                                    .red
                                    .shade300,
                              ),
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(
                        height: 12,
                      ),

                      CustomTextField(
                        hint:
                            "Email",

                        icon:
                            Icons.email,

                        controller:
                            emailController,
                      ),

                      const SizedBox(
                        height: 22,
                      ),

                      CustomTextField(
                        hint:
                            "Password",

                        icon:
                            Icons.lock,

                        obscure: true,

                        controller:
                            passwordController,
                      ),

                      const SizedBox(
                        height: 22,
                      ),

                      CustomTextField(
                        hint:
                            "Blood Group",

                        icon:
                            Icons.bloodtype,

                        controller:
                            bloodGroupController,
                      ),

                      const SizedBox(
                        height: 35,
                      ),

                      CustomButton(
                        text:
                            "Create Account",

                        onTap: () async {

                          if (!otpSent) {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(

                              const SnackBar(
                                content: Text(
                                  "Please verify phone number first",
                                ),
                              ),
                            );

                            return;
                          }

                          final user =
                              await AuthService().signUp(

                            email:
                                emailController.text.trim(),

                            password:
                                passwordController.text.trim(),
                          );

                          if (user != null) {

                            await FirestoreService()
                                .saveUserData(

                              uid: user.uid,

                              name:
                                  nameController.text.trim(),

                              email:
                                  emailController.text.trim(),

                              bloodGroup:
                                  bloodGroupController.text.trim(),
                            );

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(

                              const SnackBar(
                                content: Text(
                                  "Account Created Successfully",
                                ),
                              ),
                            );

                            Navigator.pushReplacement(
                              context,

                              MaterialPageRoute(
                                builder: (_) =>
                                    const HomeScreen(),
                              ),
                            );

                          } else {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(

                              const SnackBar(
                                content: Text(
                                  "Signup Failed",
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: 400.ms,
                    )
                    .slideY(
                      begin: 0.15,
                    ),

                const SizedBox(
                  height: 35,
                ),

                Center(
                  child: Column(
                    children: [

                      const Text(
                        "AI Emergency Protection",

                        style: TextStyle(
                          color:
                              Colors.white60,

                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment:
                            WrapAlignment.center,

                        children: [

                          buildMiniFeature(
                            icon:
                                Icons.security,

                            title:
                                "Secure",
                          ),

                          buildMiniFeature(
                            icon:
                                Icons.gps_fixed,

                            title:
                                "Tracking",
                          ),

                          buildMiniFeature(
                            icon:
                                Icons.warning,

                            title:
                                "SOS AI",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGlassCard({
    required Widget child,
  }) {

    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(
        24,
      ),

      decoration: BoxDecoration(

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment.bottomRight,

          colors: [

            Colors.white.withValues(
              alpha: 0.06,
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
          color: Colors.white
              .withValues(
            alpha: 0.08,
          ),
        ),

        boxShadow: [

          BoxShadow(
            color: Colors.red
                .withValues(
              alpha: 0.08,
            ),

            blurRadius: 24,
            spreadRadius: 1,
          ),
        ],
      ),

      child: child,
    );
  }

  Widget buildMiniFeature({

    required IconData icon,

    required String title,
  }) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),

      decoration: BoxDecoration(

        color:
            Colors.white.withValues(
          alpha: 0.05,
        ),

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        border: Border.all(
          color: Colors.white
              .withValues(
            alpha: 0.08,
          ),
        ),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,

        children: [

          Icon(
            icon,
            color: Colors.red,
            size: 18,
          ),

          const SizedBox(
            width: 8,
          ),

          Text(
            title,

            style: const TextStyle(
              color:
                  Colors.white70,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          duration: 600.ms,
        )
        .scale();
  }
}
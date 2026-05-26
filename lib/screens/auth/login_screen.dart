import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

import '../home/home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFF090B12),

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

                const SizedBox(
                  height: 20,
                ),

                Align(
                  alignment:
                      Alignment.topRight,

                  child: Container(
                    width: 120,
                    height: 120,

                    decoration:
                        BoxDecoration(

                      shape:
                          BoxShape.circle,

                      gradient:
                          RadialGradient(

                        colors: [

                          Colors.red
                              .withValues(alpha: 0.25),

                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
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
                    "Welcome Back",

                    style: TextStyle(
                      fontSize: 42,
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
                  "Login to continue your\nAI-powered safety journey",

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
                  height: 50,
                ),

                buildGlassCard(

                  child: Column(
                    children: [

                      const Row(
                        children: [

                          Icon(
                            Icons.phone,
                            color:
                                Colors.red,
                          ),

                          SizedBox(
                            width: 12,
                          ),

                          Text(
                            "Phone Login",

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

                      const CustomTextField(
                        hint:
                            "Phone Number",

                        icon:
                            Icons.phone_android,
                      ),

                      const SizedBox(
                        height: 22,
                      ),

                      const CustomTextField(
                        hint:
                            "Password",

                        icon:
                            Icons.lock,

                        obscure: true,
                      ),

                      const SizedBox(
                        height: 32,
                      ),

                      CustomButton(
                        text:
                            "Login",

                        onTap: () {

                          Navigator.pushReplacement(
                            context,

                            MaterialPageRoute(
                              builder: (_) =>
                                  const HomeScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          const Text(
                            "Forgot Password?",

                            style: TextStyle(
                              color:
                                  Colors.white70,
                            ),
                          ),

                          TextButton(
                            onPressed: () {},

                            child: Text(
                              "Reset",

                              style: TextStyle(
                                color: Colors
                                    .red
                                    .shade300,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
                        "Secure AI Emergency Platform",

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
                                Icons
                                    .notifications_active,

                            title:
                                "Alerts",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                  children: [

                    const Text(
                      "Don't have an account?",

                      style: TextStyle(
                        color:
                            Colors.white70,
                      ),
                    ),

                    TextButton(
                      onPressed: () {

                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                const SignupScreen(),
                          ),
                        );
                      },

                      child: Text(
                        "Sign Up",

                        style: TextStyle(
                          color:
                              Colors.red
                                  .shade300,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(
                      delay: 700.ms,
                    ),

                const SizedBox(
                  height: 20,
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

            Colors.white.withValues(alpha: 0.06),

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
              .withValues(alpha: 0.08),
        ),

        boxShadow: [

          BoxShadow(
            color: Colors.red
                .withValues(alpha: 0.08),

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
            Colors.white
                .withValues(alpha: 0.05),

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        border: Border.all(
          color: Colors.white
              .withValues(alpha: 0.08),
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
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.health_and_safety,
              size: 120,
              color: Colors.red.shade400,
            )
                .animate()
                .scale(duration: 1000.ms)
                .fadeIn(),

            const SizedBox(height: 20),

            const Text(
              "SMART SOS",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            )
                .animate()
                .fadeIn(delay: 500.ms),

            const SizedBox(height: 10),

            const Text(
              "AI Powered Road Safety",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            )
                .animate()
                .fadeIn(delay: 900.ms),
          ],
        ),
      ),
    );
  }
}
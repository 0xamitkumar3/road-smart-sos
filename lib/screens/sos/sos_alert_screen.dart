import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'emergency_screen.dart';

class SOSAlertScreen extends StatefulWidget {
  const SOSAlertScreen({super.key});

  @override
  State<SOSAlertScreen> createState() => _SOSAlertScreenState();
}

class _SOSAlertScreenState extends State<SOSAlertScreen> {

  int seconds = 10;

  Timer? timer;

  final FlutterTts flutterTts = FlutterTts();

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    startEmergencyFlow();
  }

  Future<void> startEmergencyFlow() async {

    await flutterTts.speak(
      "Possible accident detected. Are you safe?",
    );

    startTimer();
  }

  void startTimer() {

    timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {

        if (seconds > 0) {

          setState(() {
            seconds--;
          });

        } else {

          timer.cancel();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const EmergencyScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {

    timer?.cancel();

    flutterTts.stop();

    audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                Icons.warning_amber_rounded,
                size: 120,
                color: Colors.red.shade400,
              ),

              const SizedBox(height: 30),

              const Text(
                "ACCIDENT DETECTED",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Emergency SOS will trigger automatically.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50),

              CircularPercentIndicator(
                radius: 100,
                lineWidth: 15,
                percent: seconds / 10,
                center: Text(
                  "$seconds",
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                progressColor: Colors.red.shade400,
                backgroundColor: Colors.white12,
                circularStrokeCap: CircularStrokeCap.round,
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 65,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  onPressed: () {

                    timer?.cancel();

                    Navigator.pop(context);
                  },

                  child: const Text(
                    "I'M SAFE",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
}
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../services/contact_service.dart';
import '../../services/sms_service.dart';
import '../../services/sos_service.dart';

import 'emergency_screen.dart';

class SOSAlertScreen extends StatefulWidget {

  const SOSAlertScreen({
    super.key,
  });

  @override
  State<SOSAlertScreen> createState() =>
      _SOSAlertScreenState();
}

class _SOSAlertScreenState
    extends State<SOSAlertScreen> {

  int seconds = 10;

  Timer? timer;

  bool sosTriggered = false;

  final FlutterTts flutterTts =
      FlutterTts();

  final AudioPlayer audioPlayer =
      AudioPlayer();

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

      (timer) async {

        if (seconds > 0) {

          setState(() {

            seconds--;
          });

        } else {

          timer.cancel();

          await triggerSOS();

          if (!mounted) return;

          Navigator.pushReplacement(

            context,

            MaterialPageRoute(
              builder: (_) =>
                  const EmergencyScreen(),
            ),
          );
        }
      },
    );
  }

  Future<void> triggerSOS() async {

    if (sosTriggered) return;

    sosTriggered = true;

    try {

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission ==
          LocationPermission.denied) {

        permission =
            await Geolocator
                .requestPermission();
      }

      if (permission ==
              LocationPermission.denied ||
          permission ==
              LocationPermission
                  .deniedForever) {

        return;
      }

      final position =
          await Geolocator
              .getCurrentPosition(

        desiredAccuracy:
            LocationAccuracy.high,
      );

      final user =
          FirebaseAuth
              .instance
              .currentUser;

      if (user == null) return;

      await SOSService()
          .sendSOSAlert(

        uid: user.uid,

        email:
            user.email ??
                "unknown@email.com",

        latitude:
            position.latitude,

        longitude:
            position.longitude,
      );

      final contacts =
          await ContactService()
              .getEmergencyNumbers(
        user.uid,
      );

      final googleMapsLink =

          "https://www.google.com/maps/search/?api=1&query="
          "${position.latitude},${position.longitude}";

      final emergencyMessage = """

🚨 EMERGENCY SOS ALERT 🚨

Possible accident detected.

User:
${user.email}

Live Location:
$googleMapsLink

Please respond immediately.
""";

      await SMSService()
          .sendEmergencySMS(

        contacts: contacts,

        message:
            emergencyMessage,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        const SnackBar(

          backgroundColor:
              Colors.red,

          content: Text(
            "Emergency SOS Triggered Successfully",
          ),
        ),
      );

    } catch (e) {

      debugPrint(
        "SOS ERROR: $e",
      );
    }
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
      backgroundColor:
          const Color(0xFF0F111A),

      body: Center(
        child: Padding(

          padding:
              const EdgeInsets.all(
            24,
          ),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              Container(

                padding:
                    const EdgeInsets.all(
                  24,
                ),

                decoration:
                    BoxDecoration(

                  shape:
                      BoxShape.circle,

                  color:
                      Colors.red
                          .withValues(
                    alpha: 0.12,
                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                          Colors.red
                              .withValues(
                        alpha: 0.35,
                      ),

                      blurRadius: 40,
                      spreadRadius: 8,
                    ),
                  ],
                ),

                child: Icon(
                  Icons.warning_amber_rounded,
                  size: 120,
                  color:
                      Colors.red.shade400,
                ),
              ),

              const SizedBox(
                height: 35,
              ),

              const Text(

                "ACCIDENT DETECTED",

                textAlign:
                    TextAlign.center,

                style: TextStyle(

                  fontSize: 34,

                  fontWeight:
                      FontWeight.bold,

                  letterSpacing: 2,

                  color:
                      Colors.white,
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              const Text(

                "Emergency SOS will trigger automatically if no response is detected.",

                style: TextStyle(

                  fontSize: 18,

                  color:
                      Colors.white70,

                  height: 1.5,
                ),

                textAlign:
                    TextAlign.center,
              ),

              const SizedBox(
                height: 55,
              ),

              CircularPercentIndicator(

                radius: 110,

                lineWidth: 16,

                percent:
                    seconds / 10,

                animation: true,

                animateFromLastPercent:
                    true,

                center: Text(

                  "$seconds",

                  style:
                      const TextStyle(

                    fontSize: 56,

                    fontWeight:
                        FontWeight.bold,

                    color:
                        Colors.white,
                  ),
                ),

                progressColor:
                    Colors.red.shade400,

                backgroundColor:
                    Colors.white12,

                circularStrokeCap:
                    CircularStrokeCap.round,
              ),

              const SizedBox(
                height: 55,
              ),

              SizedBox(

                width:
                    double.infinity,

                height: 65,

                child: ElevatedButton(

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        Colors.green,

                    elevation: 8,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  onPressed: () {

                    timer?.cancel();

                    Navigator.pop(
                      context,
                    );
                  },

                  child: const Text(

                    "I'M SAFE",

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              const Text(

                "AI Safety Monitoring Active",

                style: TextStyle(
                  color:
                      Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
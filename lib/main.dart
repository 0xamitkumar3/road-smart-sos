import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const SmartSOSApp());
}

class SmartSOSApp extends StatelessWidget {
  const SmartSOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart SOS',
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
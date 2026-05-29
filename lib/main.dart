import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/home/home_screen.dart';

import 'services/notification_service/notification_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await NotificationService()
      .initNotification();

  runApp(const SmartSOSApp());
}

class SmartSOSApp extends StatelessWidget {

  const SmartSOSApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner:
          false,

      title: 'Smart SOS',

      theme: ThemeData.dark(),

      home:
          FirebaseAuth
                      .instance
                      .currentUser !=
                  null

              ? const HomeScreen()

              : const SplashScreen(),
    );
  }
}
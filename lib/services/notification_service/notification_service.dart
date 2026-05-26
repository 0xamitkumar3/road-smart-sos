import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  final FlutterLocalNotificationsPlugin
      notificationsPlugin =
          FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {

    const AndroidInitializationSettings
        androidSettings =
            AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const InitializationSettings
        settings =
            InitializationSettings(
      android: androidSettings,
    );

    await notificationsPlugin.initialize(
      settings,
    );
  }

  Future<void> showEmergencyNotification()
      async {

    const AndroidNotificationDetails
        androidDetails =
            AndroidNotificationDetails(

      'emergency_channel',

      'Emergency Alerts',

      channelDescription:
          'Emergency SOS notifications',

      importance: Importance.max,

      priority: Priority.high,
    );

    const NotificationDetails
        details =
            NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.show(

      0,

      '🚨 Emergency Alert',

      'Possible accident detected. Emergency services notified.',

      details,
    );
  }
}
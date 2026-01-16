import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(iOS: iosSettings);

    await notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showSimpleNotification({
    required String title,
    required String body,
  }) async {
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      iOS: iosDetails,
    );

    await notificationsPlugin.show(0, title, body, notificationDetails);
  }
}

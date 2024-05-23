import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    try {
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
          if (response.payload != null) {
            log('Notification payload: ${response.payload}');
          }
        },
      );

      // Create a notification channel for Android 8.0+
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'channel_id', // id
        'Channel Name', // name
        description: 'Channel Description', // description
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      log('Notification service initialized');
    } catch (e) {
      log('Error initializing notification service: $e');
    }
  }

  Future<void> showNotificationAndroid(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id', // id of the channel
      'Channel Name', // name of the channel
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    try {
      await flutterLocalNotificationsPlugin
          .show(1, title, value, notificationDetails, payload: 'Not present');
      log('Android notification displayed');
    } catch (e) {
      log('Error showing Android notification: $e');
    }
  }

  Future<void> showNotificationIos(String title, String value) async {
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
      badgeNumber: 1,
      subtitle: 'Subtitle',
      threadIdentifier: 'thread_id',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(iOS: iOSPlatformChannelSpecifics);

    try {
      await flutterLocalNotificationsPlugin.show(
          1, title, value, platformChannelSpecifics,
          payload: 'Not present');
      log('iOS notification displayed');
    } catch (e) {
      log('Error showing iOS notification: $e');
    }
  }
}

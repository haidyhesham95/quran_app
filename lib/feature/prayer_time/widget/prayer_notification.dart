import 'dart:async';

import 'package:timezone/data/latest.dart' as tz;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServicePrayerTime {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static late SharedPreferences _prefs;
  static const String _notificationIdKey = 'last_notification_id';

  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse response) async {},
    );

    _prefs = await SharedPreferences.getInstance();
  }

 static Future<void> showPrayerTimeNotification(
      String label, String time, String message) async {
    try {
      final AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        '3',
        'الاذان',
        channelDescription: 'Prayer Time Notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        ongoing: true,
        sound:
            RawResourceAndroidNotificationSound('audio.mp3'.split('.').first),
      );

      final NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      final List<String> timeParts = time.split(':');
      final int hour = int.parse(timeParts[0]);
      final int minute = int.parse(timeParts[1]);

      int lastNotificationId = _prefs.getInt(_notificationIdKey) ?? 0;
      int notificationId = lastNotificationId + 1;

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        label,
        message,
        _nextInstanceOfPrayerTime(hour, minute),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents:
            DateTimeComponents.time, // Ensure it matches the time daily
      );

      await _prefs.setInt(_notificationIdKey, notificationId);
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  static tz.TZDateTime _nextInstanceOfPrayerTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}

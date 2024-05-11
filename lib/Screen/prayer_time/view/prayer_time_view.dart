import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Const/Styels.dart';
import '../../../Const/colors.dart';
import '../../../generated/assets.dart';
import '../model/time_model.dart';
import '../widget/build.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;




class PrayerTimePage extends StatefulWidget {
  @override
  _PrayerTimePageState createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  late Future<PrayerTimesModel> _prayerTimeFuture;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _prayerTimeFuture = PrayerTimeApiService.getPrayerTimes();
    LocalNotificationServicePrayerTime.init();
    schedulePrayerTimeNotifications();
  }
  Future<PrayerTimesModel> fetchPrayerTimes() async {
    return PrayerTimeApiService.getPrayerTimes();
  }

  void schedulePrayerTimeNotifications() async {
    PrayerTimesModel prayerTimes = await _prayerTimeFuture;

    LocalNotificationServicePrayerTime.showPrayerTimeNotification(
      'صلاة الفجر',
      prayerTimes.fajr,
      'حان الان موعد آذان الفجر', // Message
    );
    LocalNotificationServicePrayerTime.showPrayerTimeNotification(
      'صلاة الضهر',
      prayerTimes.dhuhr,
      'حان الان موعد آذان الضهر',
    );
    LocalNotificationServicePrayerTime.showPrayerTimeNotification(
      'صلاة العصر',
      prayerTimes.asr,
      'حان الان موعد آذان العصر',
    );
    LocalNotificationServicePrayerTime.showPrayerTimeNotification(
      'صلاة المغرب',
      prayerTimes.maghrib,
      'حان الان موعد آذان المغرب',
    );
    LocalNotificationServicePrayerTime.showPrayerTimeNotification(
      'صلاة العشاء',
      prayerTimes.isha,
      'حان الان موعد آذان العشاء',
    );
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<PrayerTimesModel>(
        future: _prayerTimeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: kgray,
              ),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(child: Text('حدث خطأ أثناء التحميل تأكَّد من اتصال الجهاز  بشبكة Wi-Fi ',style:Styles.text30 ,textAlign: TextAlign.center,)),
            );
          } else {
            final prayerTimes = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.yMEd('ar').format(DateTime.now()),
                    style: Styles.text22,
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      height: size.height * 0.7,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        color: kGreen.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PrayerTimeItem(
                            label: 'صلاة الفجر',
                            time: prayerTimes.fajr,
                          ),
                          PrayerTimeItem(
                            label: 'الشروق',
                            time: prayerTimes.sunrise,
                          ),
                          PrayerTimeItem(
                            label: 'صلاه الضهر',
                            time: prayerTimes.dhuhr,
                          ),
                          PrayerTimeItem(
                            label: 'صلاة العصر',
                            time: prayerTimes.asr,
                          ),
                          PrayerTimeItem(
                            label: 'صلاة المغرب',
                            time: prayerTimes.maghrib,
                          ),
                          PrayerTimeItem(
                            label: 'صلاة العشاء',
                            time: prayerTimes.isha,
                          ),
                          PrayerTimeItem(
                            label: 'قيام الليل',
                            time: prayerTimes.midnight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }




}




class LocalNotificationServicePrayerTime {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static late SharedPreferences _prefs;
  static const String _notificationIdKey = 'last_notification_id';

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _prefs = await SharedPreferences.getInstance();
  }

  static void showPrayerTimeNotification(
      String label, String time, String message) async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 1',
      'الاذان',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(Assets.audio),
    );

    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: android);

    final timeParts = time.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    int lastNotificationId = _prefs.getInt(_notificationIdKey) ?? 0;
    int notificationId = lastNotificationId + 1;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      label,
      message,
      _nextInstanceOfPrayerTime(hour, minute),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );

    await _prefs.setInt(_notificationIdKey, notificationId);
  }

  static tz.TZDateTime _nextInstanceOfPrayerTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}





import 'package:permission_handler/permission_handler.dart';



import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';

import '../../../Const/styels.dart';
import '../../../Const/colors.dart';

import '../model/time_model.dart';
import '../widget/build.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../widget/hijri_text.dart';
import '../widget/prayer_notification.dart';



class PrayerTimePage extends StatefulWidget {
  @override
  _PrayerTimePageState createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  late PrayerTimes prayerTimes;
  late Future<PrayerTimesModel> _prayerTimeFuture;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    initializePrayerTimes();
    _prayerTimeFuture = fetchPrayerTimes();
    LocalNotificationServicePrayerTime.init().then((_) {
      schedulePrayerTimeNotifications();
    });
  }

  void requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print('Notification permission granted.');
    } else {
      print('Notification permission denied.');
    }
  }

  void initializePrayerTimes() {
    final coordinates = Coordinates(30.0444, 31.2357);
    final params = CalculationMethod.egyptian.getParameters();
    final dateComponents = DateComponents.from(DateTime.now());
    prayerTimes = PrayerTimes(coordinates, dateComponents, params);
  }

  Future<PrayerTimesModel> fetchPrayerTimes() async {
    return PrayerTimeApiService.getPrayerTimes();
  }

  void schedulePrayerTimeNotifications() async {
    try {
      PrayerTimesModel prayerTimes = await _prayerTimeFuture;
      await LocalNotificationServicePrayerTime.showPrayerTimeNotification(
        'صلاة الفجر',
        prayerTimes.fajr,
        'حان الآن موعد آذان الفجر',
      );
      await LocalNotificationServicePrayerTime.showPrayerTimeNotification(
        'صلاة الضهر',
        prayerTimes.dhuhr,
        'حان الآن موعد آذان الضهر',
      );
      await LocalNotificationServicePrayerTime.showPrayerTimeNotification(
        'صلاة العصر',
        prayerTimes.asr,
        'حان الآن موعد آذان العصر',
      );
      await LocalNotificationServicePrayerTime.showPrayerTimeNotification(
        'صلاة المغرب',
        prayerTimes.maghrib,
        'حان الآن موعد آذان المغرب',
      );
      await LocalNotificationServicePrayerTime.showPrayerTimeNotification(
        'صلاة العشاء',
        prayerTimes.isha,
        'حان الآن موعد آذان العشاء',
      );
    } catch (e) {
      print('Error scheduling notifications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                DateFormat.yMEd('ar').format(DateTime.now()),
                style: Styles.text22,
              ),
              hijriText(),
              SizedBox(height: 15),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  height: size.height * 0.7,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: kGreen.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PrayerTimeItem(label: 'صلاة الفجر', time: prayerTimes.fajr),
                      PrayerTimeItem(label: 'الشروق', time: prayerTimes.sunrise),
                      PrayerTimeItem(label: 'صلاه الضهر', time: prayerTimes.dhuhr),
                      PrayerTimeItem(label: 'صلاة العصر', time: prayerTimes.asr),
                      PrayerTimeItem(label: 'صلاة المغرب', time: prayerTimes.maghrib),
                      PrayerTimeItem(label: 'صلاة العشاء', time: prayerTimes.isha),
                    ],
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

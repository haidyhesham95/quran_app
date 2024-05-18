import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/Const/Styels.dart';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_quran/const/Bloc/theme_cubit.dart';
import 'package:my_quran/feature/home/view/home_page.dart';
import 'package:workmanager/workmanager.dart';

import 'Const/static.dart';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// Future showNotification() async {
//   int rndmIndex = Random().nextInt(StaticVars().smallDo3a2.length - 1);
//
//   AndroidNotificationDetails androidPlatformChannelSpecifics =
//   AndroidNotificationDetails(
//     '$rndmIndex.0',
//     'تطبيق المسلم',
//     importance: Importance.max,
//     priority: Priority.high,
//     playSound: true,
//     enableVibration: true,
//   );
//
//   var platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//   );
//
//   await flutterLocalNotificationsPlugin.show(
//     rndmIndex,
//     '',
//     StaticVars().smallDo3a2[rndmIndex],
//     platformChannelSpecifics,
//   );
// }
//
// void callbackDispatcher() {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//
//   var initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );
//
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//   );
//
//   Workmanager().executeTask((task, inputData) {
//     showNotification();
//     return Future.value(true);
//   });
// }


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {


    Future.delayed(Duration(seconds: 3) ,(){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder:(_) => HomePage()
      ));
    });

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    context.read<ThemeCubit>().setTheme(
      brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
    );    return Scaffold(

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
                'assets/images/Splash.png'
            ),
            Text('القرآن الكريم',style:Styles.textStyle38)
          ],
        ),
      ),
    );
  }
}
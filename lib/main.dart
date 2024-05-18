
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_quran/Splash.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:workmanager/workmanager.dart';

import 'Const/static.dart';
import 'const/Bloc/theme_cubit.dart';
import 'feature/ahadyth/view/ahadyth.dart';
import 'feature/ahadyth/widget/hadyth_details.dart';
import 'feature/alsibaha/alsibaha.dart';
import 'feature/audio/pages/recitations.dart';
import 'feature/azkar/azkar.dart';
import 'feature/prayer_time/view/prayer_time_view.dart';
import 'feature/quran/view/Quran.dart';
import 'feature/quran/widget/quran_details_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Permission.storage.request();
  await Permission.notification.request();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  Workmanager().registerPeriodicTask(
    "1",
    "periodicNotification",
    frequency: Duration(minutes: 30),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({Key? key}) : super(key: key);

  @override


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          locale: const Locale('ar', ''),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar', ''), // Arabic
          ],
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          routes: {
            'quranPage': (context) => QuranPage(),
            'ahadyth': (context) => Hadith(),
            'prayerTime': (context) => PrayerTimePage(),
            'alsibaha': (context) => Alsibaha(),
            'recitationsPage': (context) => RecitationsPage(),
            'azkar': (context) => Azkar(context: context),
            HadythDetails.routeName: (context) => HadythDetails(),
            QuranDetailsScreen.routeName: (context) => QuranDetailsScreen(),
          },
          home: Splash(),
        );
      },
    );
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await showNotification();
    return Future.value(true);
  });
}

Future<void> showNotification() async  {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  int rndmIndex = Random().nextInt(StaticVars().smallDo3a2.length - 1);

  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    '$rndmIndex.0',
    'تطبيق المسلم',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    rndmIndex,
    '',
    StaticVars().smallDo3a2[rndmIndex],
    platformChannelSpecifics,
  );
}



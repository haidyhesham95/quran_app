import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

import 'package:my_quran/splash.dart';

import 'Const/static.dart';
import 'const/Bloc/theme_cubit.dart';
import 'feature/ahadyth/view/ahadyth.dart';
import 'feature/ahadyth/widget/hadyth_details.dart';
import 'feature/alsibaha/alsibaha.dart';
import 'feature/audio/pages/recitations.dart';
import 'feature/azkar/view/azkar_view.dart';
import 'feature/prayer_time/view/prayer_time_view.dart';
import 'feature/quran/view/quran.dart';
import 'feature/quran/widget/quran_details_screen.dart';

import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Permission.storage.request();
  await Permission.notification.request();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  Workmanager().registerPeriodicTask(
    "1",
    "periodicNotification",
    frequency: const Duration(minutes: 30),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

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
            'quranPage': (context) => const QuranPage(),
            'ahadyth': (context) => const Hadith(),
            'prayerTime': (context) => const PrayerTimePage(),
            'alsibaha': (context) => const Alsibaha(),
            'recitationsPage': (context) => const RecitationsPage(),
            'azkar': (context) => AzkarView(context: context),
            HadythDetails.routeName: (context) => const HadythDetails(),
            QuranDetailsScreen.routeName: (context) =>
                const QuranDetailsScreen(),
          },
          home: const Splash(),
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

Future<void> showNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  int rndmIndex = Random().nextInt(StaticVars().smallDo3a2.length - 1);

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
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

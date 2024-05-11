import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/Screen/Ahadyth/HadythDetails.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Screen/Home/Bloc/theme_cubit.dart';
import 'Screen/Quran/quran_details_screen.dart';

import 'Screen/prayer_time/notification/work_manager.dart';
import 'Screen/prayer_time/view/prayer_time_view.dart';
import 'Splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



  void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

     LocalNotificationService.streamController.stream.listen((notificationResponse) {

     });
     await Future.wait([
      LocalNotificationService.init(),
        LocalNotificationServicePrayerTime.init(),
    //  WorkManagerService().init(),

    ]);




  await Permission.storage.request();
  await Permission.notification.request();

  var status = await Permission.notification.request();
    runApp(const MyApp());


  }




class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    LocalNotificationService.init();
    LocalNotificationService.showDailySchduledNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocConsumer<ThemeCubit, ThemeState>(listener: (context, state) {
      }, builder: (context, state) {
        ThemeCubit cubit = ThemeCubit.get(context);
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


          theme: ThemeData(
            brightness:cubit.isDark ? Brightness.dark : Brightness.light,

          ),

          routes: {
            HadythDetails.routeName: (context) => HadythDetails(),
            QuranDetailsScreen.routeName: (context) => QuranDetailsScreen()
          },
          home: Splash(),
        );
      }),
    );
  }
}

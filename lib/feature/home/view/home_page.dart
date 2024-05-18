import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:my_quran/Const/styels.dart';
import 'package:my_quran/feature/home/widget/home_item.dart';
import 'package:workmanager/workmanager.dart';

import '../widget/date.dart';
import '../widget/quran_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<HomeCategory> categories = [

    HomeCategory(
      text: "القراء",
      icon: const Icon(FlutterIslamicIcons.prayingPerson),
      onTap: (context) {
        Navigator.pushNamed(context, 'recitationsPage');
      },
    ),
    HomeCategory(
      text: "الاحاديث",
      icon: const Icon(FlutterIslamicIcons.quran),
      onTap: (context) {
        Navigator.pushNamed(context, 'ahadyth');
      },
    ),
    HomeCategory(
      text: "الأذكار",
      icon: const Icon(CupertinoIcons.alarm),
      onTap: (context) {
        Navigator.pushNamed(context, 'azkar');
      },
    ),
    HomeCategory(
      text: "أوقات الصلاة",
      icon: const Icon(FlutterIslamicIcons.solidMosque),
      onTap: (context) {
        Navigator.pushNamed(context, 'prayerTime');
      },
    ),
    HomeCategory(
      text: "المسبحة",
      icon: const Icon(FlutterIslamicIcons.tasbih3),
      onTap: (context) {
        Navigator.pushNamed(context, 'alsibaha');
      },
    ),
    HomeCategory(
      text: "الاشعارات",
      icon: const Icon(Icons.notifications_active),
      onTap: (context) {},
    ),
  ];

  // void initState() {
  //
  //
  //   Workmanager().registerPeriodicTask(
  //     "1",
  //     "periodic Notification",
  //     frequency: Duration(minutes: 30),
  //   );
  //
  //   Workmanager().registerPeriodicTask(
  //     "2",
  //     "periodic Notification at day",
  //     frequency: Duration(days: 1),
  //   );
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(
        'القائمة الرئيسية',
        style: Styles.textStyleName22Bold,
      ),
      centerTitle: true,
    ),
    body: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 5),
          date(context),
          const SizedBox(height: 20),
          quranCard(context),
          const SizedBox(height: 20),
          Center(
            child: GridView.builder(
       physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                mainAxisExtent: 100,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return homeItem(categories[index], context);
              },
            ),
          ),
        ],
      ),
    ),
      ),
      );
  }
}

class HomeCategory {
  final String text;
  final Icon icon;
  final void Function(BuildContext context)? onTap;

  HomeCategory({
    required this.text,
    required this.icon,
    required this.onTap,
  });
}

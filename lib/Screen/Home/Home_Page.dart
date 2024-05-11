import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Const/colors.dart';
import 'package:my_quran/Screen/Azkar/Azkar.dart';
import 'package:my_quran/Screen/prayer_time/view/prayer_time_view.dart';
import '../../Alsibaha/Alsibaha.dart';
import '../Ahadyth/Ahadyth.dart';
import 'dart:ui';

import '../Quran/Quran.dart';
import 'Bloc/theme_cubit.dart';
class Home_Page extends StatefulWidget implements PreferredSizeWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
  @override
  Size get preferredSize => throw UnimplementedError();
}

class _Home_PageState extends State<Home_Page> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading:  IconButton(
            onPressed: (){
              Navigator.push (context, MaterialPageRoute  (
                  builder:(context)=> Quran_page()));

            },
              icon: Icon(FlutterIslamicIcons.quran2,size: 25,)),

          actions:  [

            Padding(
              padding: EdgeInsets.only(right: 5),
              child: BlocConsumer<ThemeCubit, ThemeState>(
                listener: (context, state) {},
                builder: (BuildContext context, ThemeState state) {
                  ThemeCubit cubit = ThemeCubit.get(context);

                  return  IconButton(
                      onPressed: () {
                        cubit.changeTheme();
                      },
                      icon: Icon(Icons.dark_mode_outlined,size: 27,));

                }),
            ),
          ],
          iconTheme:const IconThemeData(color: kGreen) ,
          backgroundColor: Colors.transparent,
          title:  Center(
            child: Text(
              ' القرآن الكريم',
              style: GoogleFonts.amiriQuran( fontWeight: FontWeight.bold,
                color: kGreen)
          ),
          ),
          bottom:  TabBar(
            isScrollable: true,

            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.grey.withOpacity(0.5),
            indicatorColor: kGreen,
            splashBorderRadius: BorderRadius.circular(8),

            labelColor: kgray,
            tabs: [
              Tab(
                text: 'أذكار المسلم ',


              ),

              Tab(
                text: 'الأحاديث',
              ),
              Tab(
                text: 'التسابيح',
              ),
              Tab(
                text: 'أوقات الصلاة',
              ),


            ],
          ),
        ),

       body:  TabBarView(
         children: [
           Azkar(context: context,),
           Ahadyth(),
           Alsibaha(),
           PrayerTimePage(),



         ],
       ),


      ),
    );
  }
}

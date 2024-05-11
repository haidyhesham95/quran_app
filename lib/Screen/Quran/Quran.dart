import 'package:flutter/material.dart';
import 'package:my_quran/Screen/Quran/List.dart';
import 'package:my_quran/Screen/Quran/quran_details_screen.dart';
import 'package:my_quran/Widget/app_bar_widget.dart';

import 'package:my_quran/Widget/list_item.dart';
import '../../Const/Styels.dart';
import '../../Const/colors.dart';
import '../audio/pages/recitations.dart';



class Quran_page extends StatelessWidget {
  const Quran_page({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context, 'القرآن الكريم',style: Styles.textStyleName23,
    actions: [ IconButton(
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => RecitationsPage()));
              },
          icon: Icon(Icons.multitrack_audio_outlined,size: 25,color: kGreen,)),
          ],

      ),

      body:Column(
    children: [
    Expanded(
    child: ListView.builder(
      itemCount: quranDetails.length,
      itemBuilder: ( context,  index) {
        return ListItem(
          onTap: () {
            Navigator.pushNamed(context, QuranDetailsScreen.routeName,
                arguments: QuranModel(
                  index,
                  quranDetails[index]['name']??'',
                ));
          },
          data:quranDetails[index]['name']??'',
          text: quranDetails[index]['id'].toString()??'',);

      },


    ),
    )

    ],
    ),
    );
  }
}

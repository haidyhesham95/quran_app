import 'package:flutter/material.dart';
import 'package:my_quran/feature/Quran/widget/List.dart';
import 'package:my_quran/feature/quran/widget/quran_details_screen.dart';

import '../../../Const/styels.dart';
import '../../../Const/colors.dart';
import '../../../const/widgets/app_bar_widget.dart';
import '../../../const/widgets/list_item.dart';
import '../../audio/pages/recitations.dart';



class QuranPage extends StatelessWidget {
  const QuranPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context, 'القرآن الكريم',style: Styles.textStyleName23,


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
          value: 6,
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


import 'package:flutter/material.dart';
import 'package:my_quran/Const/Styels.dart';
import 'package:my_quran/Screen/Ahadyth/HadythDetails.dart';
import '../../Widget/list_item.dart';
import 'listttt.dart';

class Ahadyth extends StatelessWidget {
   Ahadyth({super.key,});

   @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20,bottom: 10),
      itemCount: ahadythDetails.length,
      itemBuilder: (BuildContext context, int index) {
        return ListItem(
          onTap: () {
            Navigator.pushNamed(context, HadythDetails.routeName,
                arguments: HadythModel(
                    index,
                    ahadythDetails[index]['name']));

          },
          data:ahadythDetails[index]['name'],
          style: Styles.textStyleName20,
          text: ahadythDetails[index]['id'].toString(),
        );
      },
    );
  }
}


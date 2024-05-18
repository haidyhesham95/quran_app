import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Const/styels.dart';
import '../../Const/colors.dart';
import 'Map.dart';
import 'item_data.dart';

class AzkarMassa extends StatelessWidget {
const  AzkarMassa({super.key,});

  @override
  Widget build(BuildContext context) {
    List<dynamic>contentData=azkar[0]['أذكار المساء'];

    return ItemData(appText: 'أذكار المساء', itemCount: contentData.length, textData: contentData,);

  }
}

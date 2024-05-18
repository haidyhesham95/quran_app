import 'package:flutter/material.dart';

import 'Map.dart';
import 'item_data.dart';

class AzkarSaba7 extends StatelessWidget {
 const AzkarSaba7({super.key,});

  @override
  Widget build(BuildContext context) {
    List<dynamic>contentData=azkar[0]['أذكار الصباح'];


    return ItemData(appText: 'أذكار الصباح', itemCount: contentData.length, textData: contentData,);

  }
}

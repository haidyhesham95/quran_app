import 'package:flutter/material.dart';

import 'Map.dart';
import 'item_data.dart';
class AzkarNoom extends StatelessWidget {
 const  AzkarNoom({super.key});
  @override
  Widget build(BuildContext context) {
    List<dynamic>contentData=azkar[0]['أذكار النوم'];

    return ItemData(appText: 'أذكار النوم', itemCount: contentData.length, textData: contentData,);

  }
}

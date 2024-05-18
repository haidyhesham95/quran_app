import 'package:flutter/material.dart';

import 'Map.dart';
import 'item_data.dart';
class AzkarAstikaz extends StatelessWidget {
  const AzkarAstikaz({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic>contentData=azkar[0]['أذكار الاستيقاظ'];

    return ItemData(appText: 'أذكار الاستيقاظ', itemCount: contentData.length, textData: contentData,);
  }
}

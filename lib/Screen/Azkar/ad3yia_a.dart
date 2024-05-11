import 'package:flutter/material.dart';
import 'Map.dart';
import 'item_data.dart';

class Ad3yiaA extends StatelessWidget {
  const Ad3yiaA({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic>contentData=azkar[0]['أدعية الأنبياء'];

    return ItemData(appText: 'أدعية الأنبياء', itemCount: contentData.length, textData: contentData,);

  }
}

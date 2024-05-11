import 'package:flutter/material.dart';

import 'Map.dart';
import 'item_data.dart';
class Ad3yiaQ extends StatelessWidget {
 const  Ad3yiaQ({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic>contentData=azkar[0]['أدعية قرآنية'];

    return ItemData(appText: 'أدعية قرآنية', itemCount: contentData.length, textData: contentData,);
  }
}

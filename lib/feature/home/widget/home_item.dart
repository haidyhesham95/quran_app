import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_quran/feature/home/view/home_page.dart';

import '../../../Const/styels.dart';
import '../../../Const/colors.dart';

Widget homeItem(HomeCategory item, BuildContext context) {
  final size = MediaQuery.of(context).size;

  return SizedBox(
    height: size.height*0.85,
    child: InkWell(
      onTap: () => item.onTap?.call(context),
      child: Card(
        elevation: 3,

        color: kgray.withOpacity(0.9),
        child: Center(
          child: ListTile(
           // enabled: false,
            leading:  Icon(item.icon.icon,size: 25,
                color: Colors.blueGrey.shade700
            ),
            title: Text(item.text,style: Styles.textt22,), // Replace Styles.textt22 with actual text style


      ),
        ),
      ),
    ),
  );
}

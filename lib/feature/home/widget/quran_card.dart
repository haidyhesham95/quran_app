import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

import '../../../Const/styels.dart';
import '../../../Const/colors.dart';

SizedBox quranCard(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return SizedBox(
      height: size.height * 0.1,
      child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'quranPage');
          },
          child: Card(
              elevation: 3,
              color: kgray.withOpacity(0.9),
              child: Center(
                  child: ListTile(
                leading: Icon(FlutterIslamicIcons.quran2,
                    size: 25, color: Colors.blueGrey.shade700),
                title: Text(
                  "القرآن الكريم",
                  style: Styles.textt22,
                ),
              )))));
}

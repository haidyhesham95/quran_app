import 'package:flutter/material.dart';
import 'package:my_quran/Const/Styels.dart';

import '../Const/colors.dart';

class Alsibaha extends StatefulWidget {
   Alsibaha({super.key});

  @override
  State<Alsibaha> createState() => _AlsibahaState();
}

class _AlsibahaState extends State<Alsibaha> {
  int scount = -99;

  int aCount = -33;

  int allaAkbrCount = -66;

  int count = 0;

  String tsbehText = "الحمد لله";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            addTasbeh();
          },
          child: Container(
            height:size.height * 0.40,
            decoration: BoxDecoration(
              color: kGreen.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(
                  "$count",
                  textAlign: TextAlign.center,
                  style: Styles.textStyle40,
                )),
          ),
        ),
        Text(
          tsbehText,
          style: Styles.text38,
        )
      ],
    );
  }

  void addTasbeh() {
    setState(() {
      count++;
      aCount++;
      scount++;
      allaAkbrCount++;
      if (count == 33) {
        count = 0;
        if (aCount == 0) {
          tsbehText = "الله اكبر ";
        }
        if (allaAkbrCount == 0) {
          tsbehText = "سبحان الله";
        }
        if (scount == 0) {
          tsbehText = "الحمد لله";
          scount = -99;
          aCount = -33;
          allaAkbrCount = -66;
        }

      }
    });
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_quran/Const/styels.dart';

import '../../Const/colors.dart';
import '../../const/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:my_quran/Const/styels.dart';

import '../../Const/colors.dart';
import '../../const/widgets/app_bar_widget.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math';


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
    final containerSize = size.height * 0.40;

    return Scaffold(
      appBar:appbarWidget(context, 'المسبحه الالكترونيه'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                addTasbeh();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(containerSize, containerSize),
                    painter: DashedBorderPainter(count: count),
                  ),
                  Container(
                    height: containerSize,
                    width: containerSize,
                    decoration: BoxDecoration(
                      color: kGreen.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child:  Center(
              child: Text(
              "$count",
                textAlign: TextAlign.center,
                style: Styles.textStyle40,
              )),
                  ),

                ],
              ),
            ),
            Text(
              tsbehText,
              style: Styles.text38,
            )
          ],
        ),
      ),
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

class DashedBorderPainter extends CustomPainter {
  final int count;

  DashedBorderPainter({required this.count});

  @override
  void paint(Canvas canvas, Size size) {
    final double dashWidth = 6.0; // Adjust this to change the dash width
    final double dashSpace = 25.0; // Adjust this to change the space between dashes
    final double radius = size.width / 2;

    final Paint paint = Paint()
      ..color = kGreen
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    double startAngle = 0.0;
    for (int i = 0; i < count; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        dashWidth / radius,
        false,
        paint,
      );
      startAngle += (dashWidth + dashSpace) / radius;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}






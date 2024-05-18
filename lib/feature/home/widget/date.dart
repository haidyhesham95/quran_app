import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../Const/styels.dart';
import '../../../Const/colors.dart';
import '../../../generated/assets.dart';
import '../../prayer_time/widget/hijri_text.dart';

Container date ( BuildContext context){
  final size = MediaQuery.of(context).size;

  return Container(
      decoration: BoxDecoration(
          color: kgray.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Stack(
          children:[
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Text(
                      DateFormat.yMEd('ar').format(DateTime.now()),
                      style: Styles.text14,
                    ),
                    hijriText(
                      style: Styles.text14,
                    ),
                  ]),
            ),
            Image.asset(Assets.imagesGround,fit: BoxFit.fill,height:size.height * 0.20,width: size.width,opacity:const AlwaysStoppedAnimation(0.9))])



  );
}
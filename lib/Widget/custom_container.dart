import 'package:flutter/cupertino.dart';

import '../Const/Styels.dart';
import '../Const/colors.dart';

Center customContainer (context,  int? itemCount, List text,{TextStyle? style}){
  final size = MediaQuery.of(context).size;
return Center(
child: Container(
height: size.height*0.85,
width: size.width* 0.9,
decoration: BoxDecoration(
color: kGreen.withOpacity(0.3),
borderRadius: const BorderRadius.all(Radius.circular(12))),
  child:   ListView.builder(

    itemCount: itemCount,
    itemBuilder: (context, index) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
          child: Text(text[index],style:style?? Styles.textStyleName22,),
        ),
      );
    },
  ),
  ));
  }
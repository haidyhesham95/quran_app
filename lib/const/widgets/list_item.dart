import 'package:flutter/material.dart';
import 'package:my_quran/Const/styels.dart';

import '../colors.dart';


class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.onTap, required this.data, required this.text, this.style,  this.value});
  final void Function()? onTap;
  final String data;
  final  String text;
  final TextStyle? style;
  final double? value;
@override
  Widget build(BuildContext context) {
    return InkWell(
     splashColor:kGreen.withOpacity(0.2),
      onTap: onTap,
      child: Card(
        color: kgray.withOpacity(0.9),
        margin: const EdgeInsets.all(12),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),),
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: value??0),


                  child: Text(data,style: style??Styles.textStyle25,),
                ),
                CircleAvatar(
                  backgroundColor:kGreen.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Center(
                      child: Text(
                        text,
                        style: Styles.textStyle15),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),


      ),
    );
  }
}






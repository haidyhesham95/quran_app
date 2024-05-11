import 'package:flutter/material.dart';

import '../../Const/colors.dart';
import 'Azkar.dart';


  Widget buildItem(CategoryItem item,  context) {
    return GestureDetector(
      onTap:item.onTap ,
      child: Container(

        decoration: BoxDecoration(
            color: kgray,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          children: [
            Container(
                child: Image.asset(
                  item.image,
                  fit: BoxFit.fill,
                  height: 105,
                  width: 150,
                )
            ),
            Container(
                height: 30,
                decoration: BoxDecoration(
                    color: kGreen,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8))
                ),
                child: Center(
                    child:
                    Text(
                    item.text,

                      textAlign: TextAlign.center,
                    ))

            )

          ],
        ),
      ),
    );
  }


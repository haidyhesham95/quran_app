import 'package:flutter/material.dart';

import '../../Const/colors.dart';
import 'azkar.dart';

Widget buildItem(CategoryItem item, context) {
  return GestureDetector(
    onTap: item.onTap,
    child: Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: kGreen.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ], color: kgray, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
           Image.asset(
            item.image,
            fit: BoxFit.fill,
            height: 105,
            width: 150,
          ),
          Container(
              height: 30,
              decoration: const BoxDecoration(
                  color: kGreen,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
              child: Center(
                  child: Text(
                item.text,
                textAlign: TextAlign.center,
              )))
        ],
      ),
    ),
  );
}

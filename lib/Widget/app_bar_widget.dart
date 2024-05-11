import 'package:flutter/material.dart';

import '../Const/Styels.dart';
import '../Const/colors.dart';

AppBar appbarWidget (context,String appBarText, {TextStyle? style,List<Widget>? actions,Color? backgroundColor}) {
  return AppBar(
    backgroundColor: backgroundColor,
    centerTitle: true,
      title: Center(child: Text(appBarText , style: style?? Styles.textStyleName22Bold)),
    actions:actions,

    iconTheme: const IconThemeData(color: kGreen),

  );
}


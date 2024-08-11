import 'package:flutter/material.dart';

import '../Styels.dart';
import '../colors.dart';

AppBar appbarWidget(
  context,
  String appBarText, {
  TextStyle? style,
  Color? backgroundColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    centerTitle: true,
    title: Center(
      child: Text(appBarText, style: style ?? Styles.textStyleName22Bold),
    ),
    iconTheme: const IconThemeData(color: kGreen),
  );
}

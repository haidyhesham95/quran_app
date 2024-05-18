import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Positioned audioContainer(context, Widget? child) {
  return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: child,
      ));
}

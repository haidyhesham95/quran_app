import 'package:flutter/material.dart';

import '../../../Const/Styels.dart';


class PrayerTimeItem extends StatelessWidget {
  final String label;
  final String time;

  const PrayerTimeItem({
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Styles.text19),

          Text(
            time,
              style: Styles.text19),

        ],
      ),
    );
  }
}

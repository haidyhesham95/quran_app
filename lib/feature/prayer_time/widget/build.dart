import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Const/styels.dart';

class PrayerTimeItem extends StatelessWidget {
  final String label;
  final DateTime time;

  const PrayerTimeItem({
    super.key,
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
          Text(label, style: Styles.text19),
          Text(DateFormat.jm('ar').format(time), style: Styles.text19),
        ],
      ),
    );
  }
}

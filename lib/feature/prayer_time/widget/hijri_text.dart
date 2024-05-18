import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../../Const/styels.dart';

Text hijriText( {TextStyle? style}) {
  final DateTime now = DateTime.now();

  final hijriCalendar = HijriCalendar.fromDate(now);
  final String formattedHijriDate =
      '${_getArabicNumber(hijriCalendar.hDay)} ${_getArabicMonthName(hijriCalendar.hMonth)} ${_getArabicNumber(hijriCalendar.hYear)} هـ';
  return  Text(
    formattedHijriDate,
    style:style?? Styles.text22,
  );
}
String _getArabicNumber(int number) {
  final arabicNumbersMap = {
    0: '٠',
    1: '١',
    2: '٢',
    3: '٣',
    4: '٤',
    5: '٥',
    6: '٦',
    7: '٧',
    8: '٨',
    9: '٩',
  };

  final List<String> digits = number.toString().split('');
  String arabicNumber = '';
  digits.forEach((digit) {
    arabicNumber += arabicNumbersMap[int.parse(digit)] ?? digit;
  });
  return arabicNumber;
}

// Function to get Arabic month name
String _getArabicMonthName(int month) {
  switch (month) {
    case 1:
      return 'محرم';
    case 2:
      return 'صفر';
    case 3:
      return 'ربيع الأول';
    case 4:
      return 'ربيع الآخر';
    case 5:
      return 'جمادى الأولى';
    case 6:
      return 'جمادى الآخرة';
    case 7:
      return 'رجب';
    case 8:
      return 'شعبان';
    case 9:
      return 'رمضان';
    case 10:
      return 'شوال';
    case 11:
      return 'ذو القعدة';
    case 12:
      return 'ذو الحجة';
    default:
      return '';
  }
}
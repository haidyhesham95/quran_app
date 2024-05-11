import 'dart:convert';
import 'package:http/http.dart'as http;
import 'dart:io';
import 'package:intl/intl.dart';


class PrayerTimesModel {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String Firstthird;

  PrayerTimesModel( {
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.Firstthird,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimesModel(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      sunset: json['Sunset'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      imsak: json['Imsak'],
      midnight: json['Midnight'],
      Firstthird: json['Firstthird'],
    );
  }
}






class PrayerTimeApiService {
  static const String _apiBaseUrl = "https://api.aladhan.com/v1/timingsByAddress";
  static String getApiUrl(String formattedDate) => "$_apiBaseUrl/$formattedDate?address=cairo";



  static Future<PrayerTimesModel> getPrayerTimes() async {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now); // Use the correct date format

    final String apiUrl = getApiUrl(formattedDate);

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final timings = jsonData['data']['timings'];
        return PrayerTimesModel.fromJson(timings);
      } else {
        throw Exception('Failed to load prayer times: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to connect to the server: $e');
    } catch (e) {
      throw Exception('Failed to load prayer times: $e');
    }
  }
}

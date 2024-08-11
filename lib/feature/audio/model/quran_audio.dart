
import 'dart:convert';

import 'package:http/http.dart' as http;
class SoundModel {
  int? id;
  String? audioUrl;


      SoundModel({
    this.id,

    this.audioUrl,
  });

  factory SoundModel.fromJson(Map<String, dynamic> json) {
    return SoundModel(
      id: json['id'],
      audioUrl: json['audio_url']?.toString(),
    );
  }

  static List<SoundModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => SoundModel.fromJson(item)).toList();
  }
}

Future<List<SoundModel>> fetchSurahsAudio(String reciterId) async {
  final apiUrl = "https://api.quran.com/api/v4/chapter_recitations/$reciterId?language=ar";

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> recitationsJson = jsonData['audio_files'] ?? [];

      List<SoundModel> audio = recitationsJson.map((recitationJson) {
        return SoundModel.fromJson(recitationJson);
      }).toList();

      return audio;
    } else {
      throw Exception("Failed to load reciter surahs audio. Status code: ${response.statusCode}");
    }
  } catch (error) {
    throw Exception("Error loading reciter surahs audio: $error");
  }
}

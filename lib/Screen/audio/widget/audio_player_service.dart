import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  late AudioPlayer _audioPlayer;

  factory AudioPlayerService() {
    return _instance;
  }

  AudioPlayerService._internal() {
    _audioPlayer = AudioPlayer();
  }

  AudioPlayer get audioPlayer => _audioPlayer;
}

import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:my_quran/Screen/audio/widget/audio_container.dart';
import 'package:my_quran/Widget/app_bar_widget.dart';
import 'package:rxdart/rxdart.dart';

import '../../../Const/Styels.dart';
import '../../../Const/colors.dart';
import '../../Quran/List.dart';
import '../model/quran_audio.dart';
import '../widget/audio_player_service.dart';
import '../widget/position_data.dart';
import '../widget/progress.dart';






class ReciterSurahsPage extends StatefulWidget {
  final String reciterId;
  final String appBarText;

  const ReciterSurahsPage({Key? key, required this.reciterId, required this.appBarText}) : super(key: key);

  @override
  _ReciterSurahsPageState createState() => _ReciterSurahsPageState();
}

class _ReciterSurahsPageState extends State<ReciterSurahsPage> {
  late Future<List<SoundModel>> _surahsAudioFuture;
  late AudioPlayer _audioPlayer; // Declare AudioPlayer instance

  Stream<PositionData> get positionDataStream => Rx.combineLatest3(
      _audioPlayer.positionStream,
      _audioPlayer.bufferedPositionStream,
      _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
          position: position,
          duration: duration ?? Duration.zero,
          bufferedPosition: bufferedPosition));

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayerService().audioPlayer; // Access the singleton instance of AudioPlayer
    _surahsAudioFuture = fetchSurahsAudio(widget.reciterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(context, widget.appBarText),
      body: FutureBuilder<List<SoundModel>>(
        future: _surahsAudioFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: kGreen,
              ),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(child: Text('حدث خطأ أثناء التحميل تأكَّد من اتصال الجهاز  بشبكة Wi-Fi ',style:Styles.text30 ,textAlign: TextAlign.center,)),
            );
          } else {
            // Data loaded successfully
            final audio = snapshot.data!;
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(top: 20,bottom: 200),
                  itemCount: audio.length,
                  itemBuilder: (context, index) {
                    final audioUrl = audio[index].audioUrl;
                    final id = audio[index].id.toString();

                    return InkWell(
                      onTap: () {
                        _audioPlayer.setUrl(audioUrl!); // Set audio URL
                        _audioPlayer.play();
                      },

                      child: SizedBox(
                        height: 80,
                        child: Card(
                          color: kgray.withOpacity(0.9),
                          elevation: 3.0,
                          child: Center(
                            child: Text("سورة${quranDetails[index]['name']}",style: Styles.textStyle25,),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                   audioContainer(context,
                     Column(
                      children: [
                        SizedBox(height: 10),
                        Controls(audioPlayer: _audioPlayer), // Add Controls widget here
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: buildProgressBar( _audioPlayer, positionDataStream),
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),

              ],
            );
          }
        },
      ),
    );
  }

}

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const Controls({Key? key, required this.audioPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: audioPlayer.seekToNext,
          icon: const Icon(Icons.skip_next_rounded),
          iconSize: 80,
          color: kGreen,
        ),
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 64.0,
                  height: 64.0,
                  child: const CircularProgressIndicator(
                    color: kGreen,
                  ),
                );
              } else if (playing == false) {
                return IconButton(
                  onPressed: audioPlayer.play,
                  icon: const Icon(Icons.play_arrow_rounded),
                  iconSize: 80,
                  color: kGreen,
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  onPressed: audioPlayer.pause,
                  icon: const Icon(Icons.pause_rounded),
                  iconSize: 80,
                  color: kGreen,
                );
              }
              return const Icon(
                Icons.play_arrow_rounded,
                size: 80,
                color: kGreen,
              );
            }),
        IconButton(
          onPressed: audioPlayer.seekToPrevious,
          icon: const Icon(Icons.skip_previous_rounded),
          iconSize: 80,
          color: kGreen,
        ),
      ],
    );
  }
}




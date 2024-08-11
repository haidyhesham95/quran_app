import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_quran/feature/audio/widget/position_data.dart';

import '../../../Const/colors.dart';
// import '../pages/quran_audio.dart';

Center buildProgressBar(AudioPlayer audioPlayer, Stream<PositionData>? stream) {
  return Center(
    child: StreamBuilder<PositionData>(
      stream: stream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return ProgressBar(
          barHeight: 8,
          progressBarColor: kGreen,
          thumbColor: kGreen,
          timeLabelTextStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          progress: positionData?.position ?? Duration.zero,
          total: positionData?.duration ?? Duration.zero,
          buffered: positionData?.bufferedPosition ?? Duration.zero,
          onSeek: audioPlayer.seek,
        );
      },
    ),
  );
}

import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/core/enum/global_enum.dart';
import 'package:jolly_podcast/core/utils/typedef.dart';

abstract class AudioPlayerRepo {
  ResultFuture<dynamic> setPodCastUrl({required String url});

  ResultFuture<Duration?> loadAudioPlaylist({
    required List<EpisodeEntity> episodes,
    required int index,
  });

  ResultFuture<dynamic> playPodcast();

  ResultFuture<dynamic> pausePodCast();

  ResultFuture<void> adjustPodcastDuration({required Duration newPosition});

  ResultFuture<void> disposeAudioPlayer();

  ResultFuture<void> playNextAudio();

  ResultFuture<void> playPreviousAudio();

  Stream<ButtonState> listenToAudioPlayerState();

  Stream<Duration> listenToAudioPostions();

  Stream<Duration> listenForAudioBuffer();

  Stream<Duration> getAudioTotalDuration();

  Stream<EpisodeEntity> playListSequenceState();
}

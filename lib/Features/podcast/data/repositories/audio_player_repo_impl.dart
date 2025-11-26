import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/Features/podcast/domain/repositories/audio_player_repo.dart';
import 'package:jolly_podcast/core/enum/global_enum.dart';
import 'package:jolly_podcast/core/error/failures.dart';
import 'package:jolly_podcast/core/utils/typedef.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerRepoImpl implements AudioPlayerRepo {
  AudioPlayerRepoImpl({required this.audioPlayer});
  final AudioPlayer audioPlayer;
  StreamController<ButtonState> streamController =
      StreamController<ButtonState>.broadcast();
  final StreamController<Duration> positionController =
      StreamController.broadcast();
  final StreamController<Duration> bufferController =
      StreamController.broadcast();
  final StreamController<Duration> totalDurationController =
      StreamController.broadcast();
  final StreamController<EpisodeEntity> currentSongController =
      StreamController.broadcast();

  @override
  ResultFuture setPodCastUrl({required String url}) async {
    try {
      final result = await audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(url)),
      );
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 100));
    }
  }

  @override
  ResultFuture<Duration?> loadAudioPlaylist({
    required List<EpisodeEntity> episodes,
    required int index,
  }) async {
    try {
      final playList = episodes
          .map(
            (element) => AudioSource.uri(
              Uri.parse(element.content_url ?? ''),
              tag: element,
            ),
          )
          .toList();
      final result = await audioPlayer.setAudioSources(
        playList,
        initialIndex: index,
      );
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 100));
    }
  }

  @override
  ResultFuture<void> adjustPodcastDuration({
    required Duration newPosition,
  }) async {
    try {
      final result = await audioPlayer.seek(newPosition);
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 100));
    }
  }

  @override
  ResultFuture<void> disposeAudioPlayer() async {
    try {
      //**POSSIBILITY OF TECHNICALLY APPLYING NULL TO THE VALUE OF THE CONTROLLER */
      final result = await audioPlayer.stop();
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 100));
    }
  }

  @override
  ResultFuture<void> pausePodCast() async {
    try {
      final result = await audioPlayer.pause();
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 100));
    }
  }

  @override
  ResultFuture<void> playPodcast() async {
    try {
      final result = await audioPlayer.play();
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 100));
    }
  }

  //**Since this already have onError Handling already,*/
  //** there is no point picking right or left */
  @override
  Stream<ButtonState> listenToAudioPlayerState() async* {
    audioPlayer.playerStateStream.listen(
      (playerState) {
        final isPlaying = playerState.playing;
        final processingState = playerState.processingState;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          streamController.add(ButtonState.laoding);
        } else if (!isPlaying) {
          streamController.add(ButtonState.paused);
        } else if (processingState != ProcessingState.completed) {
          streamController.add(ButtonState.playing);
        } else {
          audioPlayer.seek(Duration.zero);
          audioPlayer.pause();
        }
      },
      onError: (error) {
        streamController.addError(error);
      },
      onDone: () {},
    );
    yield* streamController.stream;
  }

  @override
  ResultFuture<void> playNextAudio() async {
    try {
      final result = await audioPlayer.seekToNext();
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 100));
    }
  }

  @override
  ResultFuture<void> playPreviousAudio() async {
    try {
      final result = await audioPlayer.seekToPrevious();
      return Right(result);
    } catch (e) {
      return Left(APIFailure(message: e.toString(), statusCode: 100));
    }
  }

  @override
  Stream<Duration> listenToAudioPostions() async* {
    audioPlayer.positionStream.listen((position) {
      positionController.add(position);
    }, onError: (error) => positionController.addError(error));
    yield* positionController.stream;
  }

  @override
  Stream<Duration> listenForAudioBuffer() async* {
    audioPlayer.bufferedPositionStream.listen((buffer) {
      bufferController.add(buffer);
    }, onError: (error) => bufferController.addError(error));
    yield* bufferController.stream;
  }

  @override
  Stream<Duration> getAudioTotalDuration() async* {
    audioPlayer.durationStream.listen((totalDuration) {
      totalDurationController.add(totalDuration ?? Duration.zero);
    }, onError: (error) => totalDurationController.addError(error));
    yield* totalDurationController.stream;
  }

  @override
  Stream<EpisodeEntity> playListSequenceState() async* {
    audioPlayer.sequenceStateStream.listen((sequenceState) {
      // final playList = sequenceState.effectiveSequence;
      final currentSong = sequenceState.currentSource?.tag as EpisodeEntity;
      currentSongController.add(currentSong);
      // final updatedPlayList = playList
      //     .map((episodes) => episodes.tag as EpisodeEntity)
      //     .toList();
    });
    yield* currentSongController.stream;
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/Features/podcast/domain/repositories/audio_player_repo.dart';
import 'package:jolly_podcast/core/enum/global_enum.dart';
part 'audio_player_events.dart';
part 'audio_player_states.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvents, AudioPlayerStates> {
  final AudioPlayerRepo _audioPlayerRepo;
  AudioPlayerBloc({required AudioPlayerRepo audioPlayerRepo})
    : _audioPlayerRepo = audioPlayerRepo,
      super(AudioPlayerInitial()) {
    on<SetPodCastUrl>(_setPodCastUrlEventHandler);
    on<PlayAudioPlayerEvent>(_playPodCastEventHandler);
    on<PlayerStateChangeEvent>(_playerStateChangeEventHandler);
    on<PauseAudioPlayerEvent>(_pauseAudioPlayerEventHandler);
    on<DisposeAudioPlayerEvent>(_disposeAudioPlayerEventHandler);
    on<GetCurrentAudioPosition>(_getCurrentAudioPositionEventHandler);
    on<GetCurrentAudioBufferPosition>(
      _getCurrentAudioBufferPositionEventHandler,
    );
    on<GetAudioTotalDuration>(_getAudioTotalDurationEventHandler);
    on<AdjustAudioCurrentPosition>(_adjustAudioCurrenPositionEventHandler);
    on<LoadAudioPlayList>(_loadAudioPlayListEventHandler);
    on<PlayNextAudioEvent>(_playNextAudioEventHandler);
    on<PlayPreviousAudioEvent>(_playPreviousEventHandler);
    on<GetCurrentAudioEvent>(_getCurrentSongEventHandler);
  }

  Future<void> _setPodCastUrlEventHandler(
    SetPodCastUrl event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    emit(AudioPlayerLoading());
    final result = await _audioPlayerRepo.setPodCastUrl(url: event.url);
    result.fold(
      (error) => emit(AudioPlayerErrorState(errorMessage: error.errorMessage)),
      (result) {
        add(PlayAudioPlayerEvent());
        // emit(AudioPlayerLoaded(totalAudioDuration: result));
      },
    );
  }

  Future<void> _loadAudioPlayListEventHandler(
    LoadAudioPlayList event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    final result = await _audioPlayerRepo.loadAudioPlaylist(
      episodes: event.playList,
      index: event.initialIndex,
    );
    result.fold(
      (error) => emit(AudioPlayerErrorState(errorMessage: error.errorMessage)),
      (result) {
        emit(AudioPlayerLoaded(totalAudioDuration: result ?? Duration.zero));
      },
    );
  }

  Future<void> _playPodCastEventHandler(
    PlayAudioPlayerEvent event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    final result = await _audioPlayerRepo.playPodcast();
    result.fold(
      (error) => emit(AudioPlayerErrorState(errorMessage: error.errorMessage)),
      (result) => emit(AudioPlayerPlaying(isPlaying: true)),
    );
  }

  Future<void> _pauseAudioPlayerEventHandler(
    PauseAudioPlayerEvent event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    final result = await _audioPlayerRepo.pausePodCast();
    result.fold(
      (error) => emit(AudioPlayerErrorState(errorMessage: error.errorMessage)),
      (result) => emit(AudioPlayerPaused(isPaused: true)),
    );
  }

  Future<void> _disposeAudioPlayerEventHandler(
    DisposeAudioPlayerEvent event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    final result = await _audioPlayerRepo.disposeAudioPlayer();
    result.fold(
      (error) => emit(AudioPlayerErrorState(errorMessage: error.errorMessage)),
      (_) => emit(AudioPlayerDisposed()),
    );
  }

  Future<void> _playerStateChangeEventHandler(
    PlayerStateChangeEvent event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    return emit.onEach(
      _audioPlayerRepo.listenToAudioPlayerState(),
      onData: (statechange) {
        switch (statechange) {
          case ButtonState.paused:
            return emit(AudioPlayerPaused(isPaused: true));
          case ButtonState.playing:
            return emit(AudioPlayerPlaying(isPlaying: true));
          default:
            return emit(AudioPlayerLoading());
        }
      },
    );
  }

  Future<void> _getCurrentAudioPositionEventHandler(
    GetCurrentAudioPosition event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    return emit.onEach(
      _audioPlayerRepo.listenToAudioPostions(),
      onData: (position) {
        return emit(AudioCurrentDuration(current: position));
      },
    );
  }

  Future<void> _getCurrentAudioBufferPositionEventHandler(
    GetCurrentAudioBufferPosition event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    return emit.onEach(
      _audioPlayerRepo.listenForAudioBuffer(),
      onData: (buffer) {
        return emit(AudioBufferDuration(buffer: buffer));
      },
    );
  }

  Future<void> _getAudioTotalDurationEventHandler(
    GetAudioTotalDuration event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    return emit.onEach(
      _audioPlayerRepo.getAudioTotalDuration(),
      onData: (totalDuration) {
        return emit(AudioPlayerLoaded(totalAudioDuration: totalDuration));
      },
      onError: (error, skt) {},
    );
  }

  Future<void> _getCurrentSongEventHandler(
    GetCurrentAudioEvent event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    return emit.onEach(
      _audioPlayerRepo.playListSequenceState(),
      onData: (data) {
        return emit(CurrentSongLoaded(currentEpisode: data));
      },
    );
  }

  Future<void> _adjustAudioCurrenPositionEventHandler(
    AdjustAudioCurrentPosition event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    await _audioPlayerRepo.adjustPodcastDuration(
      newPosition: event.adjustedDuration,
    );
  }

  Future<void> _playNextAudioEventHandler(
    PlayNextAudioEvent event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    await _audioPlayerRepo.playNextAudio();
  }

  Future<void> _playPreviousEventHandler(
    PlayPreviousAudioEvent event,
    Emitter<AudioPlayerStates> emit,
  ) async {
    await _audioPlayerRepo.playPreviousAudio();
  }
}

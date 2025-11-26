part of 'audio_player_bloc.dart';

sealed class AudioPlayerStates extends Equatable {
  const AudioPlayerStates();

  @override
  List<Object?> get props => [];
}

final class AudioPlayerInitial extends AudioPlayerStates {
  const AudioPlayerInitial();
}

final class AudioPlayerLoading extends AudioPlayerStates {
  const AudioPlayerLoading();
}

final class AudioCurrentDuration extends AudioPlayerStates {
  final Duration current;

  const AudioCurrentDuration({required this.current});

  @override
  List<Object?> get props => [current];
}

final class AudioBufferDuration extends AudioPlayerStates {
  final Duration buffer;

  const AudioBufferDuration({required this.buffer});

  @override
  List<Object?> get props => [buffer];
}

final class AudioPlayerLoaded extends AudioPlayerStates {
  final Duration totalAudioDuration;
  const AudioPlayerLoaded({required this.totalAudioDuration});
}

final class AudioPlayerErrorState extends AudioPlayerStates {
  final String errorMessage;
  const AudioPlayerErrorState({required this.errorMessage});
}

final class AudioPlayerPlaying extends AudioPlayerStates {
  final bool isPlaying;
  const AudioPlayerPlaying({required this.isPlaying});
}

final class AudioPlayerPaused extends AudioPlayerStates {
  final bool isPaused;
  const AudioPlayerPaused({required this.isPaused});
}

final class AudioPlayerDisposed extends AudioPlayerStates {
  const AudioPlayerDisposed();
}

final class CurrentSongLoaded extends AudioPlayerStates {
  final EpisodeEntity currentEpisode;
  const CurrentSongLoaded({required this.currentEpisode});
}

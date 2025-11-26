part of 'audio_player_bloc.dart';

sealed class AudioPlayerEvents extends Equatable {
  const AudioPlayerEvents();

  @override
  List<Object?> get props => [];
}

final class SetInitialPlayLists extends AudioPlayerEvents {
  const SetInitialPlayLists();
}

final class SetPodCastUrl extends AudioPlayerEvents {
  final String url;
  const SetPodCastUrl({required this.url});
}

final class PlayAudioPlayerEvent extends AudioPlayerEvents {
  const PlayAudioPlayerEvent();
}

final class PauseAudioPlayerEvent extends AudioPlayerEvents {
  const PauseAudioPlayerEvent();
}

final class AdjustAudioCurrentPosition extends AudioPlayerEvents {
  final Duration adjustedDuration;
  const AdjustAudioCurrentPosition({required this.adjustedDuration});
}

final class DisposeAudioPlayerEvent extends AudioPlayerEvents {
  const DisposeAudioPlayerEvent();
}

final class PlayerStateChangeEvent extends AudioPlayerEvents {
  const PlayerStateChangeEvent();
}

final class PlayNextAudioEvent extends AudioPlayerEvents {
  const PlayNextAudioEvent();
}

final class PlayPreviousAudioEvent extends AudioPlayerEvents {
  const PlayPreviousAudioEvent();
}

final class GetCurrentAudioPosition extends AudioPlayerEvents {
  const GetCurrentAudioPosition();
}

final class GetCurrentAudioBufferPosition extends AudioPlayerEvents {
  const GetCurrentAudioBufferPosition();
}

final class GetAudioTotalDuration extends AudioPlayerEvents {
  const GetAudioTotalDuration();
}

final class LoadAudioPlayList extends AudioPlayerEvents {
  final List<EpisodeEntity> playList;
  final int initialIndex;
  const LoadAudioPlayList({required this.playList, required this.initialIndex});
}

final class GetCurrentAudioEvent extends AudioPlayerEvents {
  const GetCurrentAudioEvent();
}

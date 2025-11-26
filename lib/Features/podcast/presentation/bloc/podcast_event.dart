part of 'podcast_bloc.dart';

sealed class PodcastEvent extends Equatable {
  const PodcastEvent();

  @override
  List<Object> get props => [];
}

final class GetLatestEpisodesEvent extends PodcastEvent {
  const GetLatestEpisodesEvent();
}

final class GetEditorPickEvent extends PodcastEvent {
  const GetEditorPickEvent();
}

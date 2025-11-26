part of 'podcast_bloc.dart';

sealed class PodcastState extends Equatable {
  const PodcastState();

  @override
  List<Object> get props => [];
}

final class PodcastInitial extends PodcastState {}

final class PodCastDataLoaded extends PodcastState {
  const PodCastDataLoaded({required this.podCastData});
  final List<EpisodeEntity> podCastData;
}

final class PodcastLoading extends PodcastState {}

final class PodcastDataError extends PodcastState {
  final String errorMessage;
  const PodcastDataError({required this.errorMessage});
}

final class EditorPickLoaded extends PodcastState {
  final EpisodeEntity editorPick;
  const EditorPickLoaded({required this.editorPick});
}

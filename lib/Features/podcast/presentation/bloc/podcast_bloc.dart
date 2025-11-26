import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/Features/podcast/domain/usecases/get_editor_pick.dart';
import 'package:jolly_podcast/Features/podcast/domain/usecases/latest_episodes.dart';
part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  PodcastBloc({
    required LatestEpisodesUsecase getEpisodes,
    required GetEditorPickUseCase getEditorPick,
  }) : _getEpisodes = getEpisodes,
       _getEditorPick = getEditorPick,
       super(PodcastInitial()) {
    on<GetLatestEpisodesEvent>(_getLatestEpisodesEventHandler);
    on<GetEditorPickEvent>(_getEditorPickEventHandler);
  }
  final LatestEpisodesUsecase _getEpisodes;
  final GetEditorPickUseCase _getEditorPick;

  Future<void> _getLatestEpisodesEventHandler(
    GetLatestEpisodesEvent event,
    Emitter<PodcastState> emit,
  ) async {
    emit(PodcastLoading());
    final result = await _getEpisodes();
    result.fold(
      (error) => emit(PodcastDataError(errorMessage: error.errorMessage)),
      (response) => emit(PodCastDataLoaded(podCastData: response)),
    );
  }

  Future<void> _getEditorPickEventHandler(
    GetEditorPickEvent event,
    Emitter<PodcastState> emit,
  ) async {
    final result = await _getEditorPick();
    result.fold(
      (error) => emit(PodcastDataError(errorMessage: error.errorMessage)),
      (response) => emit(EditorPickLoaded(editorPick: response)),
    );
  }
}

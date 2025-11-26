import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/Features/podcast/domain/repositories/podcast_repository.dart';
import 'package:jolly_podcast/core/usecases/usecase.dart';
import 'package:jolly_podcast/core/utils/typedef.dart';

class GetEditorPickUseCase extends UseCaseWithoutParams<EpisodeEntity> {
  const GetEditorPickUseCase(this._repository);
  final PodcastRepository _repository;
  @override
  ResultFuture<EpisodeEntity> call() => _repository.getEditorPick();
}

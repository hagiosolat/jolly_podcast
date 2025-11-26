import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/core/utils/typedef.dart';

abstract class PodcastRepository {
  ResultFuture<List<EpisodeEntity>> getLatestEpisodes();

  ResultFuture<EpisodeEntity> getEditorPick();
}

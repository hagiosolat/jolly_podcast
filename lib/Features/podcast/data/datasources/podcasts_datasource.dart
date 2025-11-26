import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';

abstract class PodCastDatasource {
  Future<List<EpisodeEntity>> getLatestEpisodes();
  Future<EpisodeEntity> getEditorPick();
}

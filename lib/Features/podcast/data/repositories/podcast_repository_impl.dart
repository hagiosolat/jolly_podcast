import 'package:fpdart/fpdart.dart';
import 'package:jolly_podcast/Features/podcast/data/datasources/podcasts_datasource.dart';
import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/Features/podcast/domain/repositories/podcast_repository.dart';
import 'package:jolly_podcast/core/error/exceptions.dart';
import 'package:jolly_podcast/core/error/failures.dart';
import 'package:jolly_podcast/core/utils/typedef.dart';

class PodcastRepositoryImpl implements PodcastRepository {
  final PodCastDatasource datasource;
  PodcastRepositoryImpl({required this.datasource});

  @override
  ResultFuture<List<EpisodeEntity>> getLatestEpisodes() async {
    try {
      final result = await datasource.getLatestEpisodes();
      return Right(result);
    } on ApiException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<EpisodeEntity> getEditorPick() async {
    try {
      final result = await datasource.getEditorPick();
      return Right(result);
    } on ApiException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}

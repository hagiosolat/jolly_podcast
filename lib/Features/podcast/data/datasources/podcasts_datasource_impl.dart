import 'package:dio/dio.dart';
import 'package:jolly_podcast/Features/podcast/data/datasources/podcasts_datasource.dart';
import 'package:jolly_podcast/Features/podcast/data/models/episode_data_model.dart';
import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/core/api/api_client.dart';
import 'package:jolly_podcast/core/api/api_error_handler.dart';
import 'package:jolly_podcast/core/common/api_name.dart';
import 'package:jolly_podcast/core/error/exceptions.dart';

class PodCastDatasourceImpl implements PodCastDatasource {
  const PodCastDatasourceImpl({required this.apiClient});
  final ApiClient apiClient;
  @override
  Future<List<EpisodeDataModel>> getLatestEpisodes() async {
    try {
      final response = await apiClient.get(ApiName.latestEpisodes);
      return List<EpisodeDataModel>.from(
        (response.data["data"]["data"]["data"] as List).map(
          (element) => EpisodeDataModel.fromMap(element),
        ),
      );
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 700);
    }
  }

  @override
  Future<EpisodeEntity> getEditorPick() async {
    try {
      final response = await apiClient.get(ApiName.editorpick);
      return EpisodeDataModel.fromMap(response.data["data"]["data"]);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 700);
    }
  }
}

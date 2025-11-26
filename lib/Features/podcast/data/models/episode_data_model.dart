// ignore_for_file: non_constant_identifier_names

import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';

class EpisodeDataModel extends EpisodeEntity {
  const EpisodeDataModel({
    super.content_url,
    super.description,
    super.id,
    super.picture_url,
    super.podcast_id,
    super.title,
  });

  factory EpisodeDataModel.fromMap(Map<String, dynamic> map) {
    return EpisodeDataModel(
      id: map['id'] != null ? map['id'] as int : null,
      podcast_id: map['podcast_id'] != null ? map['podcast_id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      content_url: map['content_url'] != null
          ? map['content_url'] as String
          : null,
      picture_url: map['picture_url'] != null
          ? map['picture_url'] as String
          : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
    );
  }
}

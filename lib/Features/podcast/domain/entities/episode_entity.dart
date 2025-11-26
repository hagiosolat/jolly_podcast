// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:equatable/equatable.dart';

class EpisodeEntity extends Equatable {
  final int? id;
  final int? podcast_id;
  final String? title;
  final String? content_url;
  final String? picture_url;
  final String? description;

  const EpisodeEntity({
    this.id,
    this.podcast_id,
    this.title,
    this.content_url,
    this.picture_url,
    this.description,
  });

  @override
  List<Object?> get props => [
    id,
    podcast_id,
    title,
    content_url,
    picture_url,
    description,
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'podcast_id': podcast_id,
      'title': title,
      'content_url': content_url,
      'picture_url': picture_url,
      'description': description,
    };
  }



  String toJson() => json.encode(toMap());

  // factory EpisodeEntity.fromJson(String source) =>
  //     EpisodeEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

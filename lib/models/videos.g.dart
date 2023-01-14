// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Videos _$VideosFromJson(Map<String, dynamic> json) => Videos()
  ..page = json['page'] as num
  ..numResults = json['numResults'] as num
  ..result = (json['result'] as List<dynamic>)
      .map((e) => Video.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$VideosToJson(Videos instance) => <String, dynamic>{
      'page': instance.page,
      'numResults': instance.numResults,
      'result': instance.result,
    };

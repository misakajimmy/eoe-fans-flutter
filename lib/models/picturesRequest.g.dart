// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picturesRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PicturesRequest _$PicturesRequestFromJson(Map<String, dynamic> json) =>
    PicturesRequest()
      ..topic_id = $enumDecode(_$PicturesTopicEnumMap, json['topic_id'])
      ..page = json['page'] as num;

Map<String, dynamic> _$PicturesRequestToJson(PicturesRequest instance) =>
    <String, dynamic>{
      'topic_id': _$PicturesTopicEnumMap[instance.topic_id]!,
      'page': instance.page,
    };

const _$PicturesTopicEnumMap = {
  PicturesTopic.zao: 29067608,
  PicturesTopic.mi: 29069147,
  PicturesTopic.wan: 28953983,
  PicturesTopic.mo: 28948378,
  PicturesTopic.un: 28950030,
  PicturesTopic.eoe: 29156150,
  PicturesTopic.all: 0,
};

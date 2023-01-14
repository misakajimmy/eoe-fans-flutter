// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videosRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideosRequest _$VideosRequestFromJson(Map<String, dynamic> json) =>
    VideosRequest()
      ..order = $enumDecode(_$VideosRequestOrderEnumMap, json['order'])
      ..page = json['page'] as num
      ..q = json['q'] as String?
      ..copyright =
          $enumDecodeNullable(_$VideosCopyrightEnumMap, json['copyright'])
      ..tname = $enumDecodeNullable(_$VideosRequestTnameEnumMap, json['tname']);

Map<String, dynamic> _$VideosRequestToJson(VideosRequest instance) =>
    <String, dynamic>{
      'order': _$VideosRequestOrderEnumMap[instance.order]!,
      'page': instance.page,
      'q': instance.q,
      'copyright': _$VideosCopyrightEnumMap[instance.copyright],
      'tname': _$VideosRequestTnameEnumMap[instance.tname],
    };

const _$VideosRequestOrderEnumMap = {
  VideosRequestOrder.pubdate: 'pubdate',
  VideosRequestOrder.view: 'view',
  VideosRequestOrder.score: 'score',
};

const _$VideosCopyrightEnumMap = {
  VideosCopyright.Original: 1,
  VideosCopyright.Reproduced: 2,
};

const _$VideosRequestTnameEnumMap = {
  VideosRequestTname.animation: 'animation',
  VideosRequestTname.music: 'music',
  VideosRequestTname.dance: 'dance',
  VideosRequestTname.game: 'game',
  VideosRequestTname.live: 'live',
  VideosRequestTname.delicacy: 'delicacy',
  VideosRequestTname.guichu: 'guichu',
  VideosRequestTname.other: 'other',
};

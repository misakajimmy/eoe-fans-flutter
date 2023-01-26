// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pictures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pictures _$PicturesFromJson(Map<String, dynamic> json) => Pictures()
  ..page = json['page'] as num
  ..total = json['total'] as num
  ..result = (json['result'] as List<dynamic>)
      .map((e) => Dynamic.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$PicturesToJson(Pictures instance) => <String, dynamic>{
      'page': instance.page,
      'total': instance.total,
      'result': instance.result,
    };

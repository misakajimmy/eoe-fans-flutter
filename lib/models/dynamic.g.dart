// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dynamic _$DynamicFromJson(Map<String, dynamic> json) => Dynamic()
  ..dynamic_id = json['dynamic_id'] as num
  ..pictures = (json['pictures'] as List<dynamic>)
      .map((e) => Picture.fromJson(e as Map<String, dynamic>))
      .toList()
  ..sent_at = json['sent_at'] as num;

Map<String, dynamic> _$DynamicToJson(Dynamic instance) => <String, dynamic>{
      'dynamic_id': instance.dynamic_id,
      'pictures': instance.pictures,
      'sent_at': instance.sent_at,
    };

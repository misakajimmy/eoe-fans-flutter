// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      json['key'] as String,
      json['lastName'] as String,
      json['firstName'] as String,
      json['bilibiliName'] as String,
      json['bilibiliUID'] as num,
      (json['nickNames'] as List<dynamic>).map((e) => e as String).toList(),
      json['color'] as String,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'key': instance.key,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'bilibiliName': instance.bilibiliName,
      'bilibiliUID': instance.bilibiliUID,
      'nickNames': instance.nickNames,
      'color': instance.color,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      json['lastName'] as String,
      json['firstName'] as String,
      json['bilibiliName'] as String,
      json['bilibiliUID'] as String,
      (json['nickNames'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'bilibiliName': instance.bilibiliName,
      'bilibiliUID': instance.bilibiliUID,
      'nickNames': instance.nickNames,
    };

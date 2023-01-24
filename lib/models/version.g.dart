// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Version _$VersionFromJson(Map<String, dynamic> json) => Version()
  ..version = json['version'] as String
  ..version_message = json['version_message'] as String
  ..download_url = json['download_url'] as Map<String, dynamic>
  ..updated_at = json['updated_at'] as String;

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'version': instance.version,
      'version_message': instance.version_message,
      'download_url': instance.download_url,
      'updated_at': instance.updated_at,
    };

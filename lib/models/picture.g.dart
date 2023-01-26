// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Picture _$PictureFromJson(Map<String, dynamic> json) => Picture()
  ..img_height = json['img_height'] as num
  ..img_size = json['img_size'] as num
  ..img_width = json['img_width'] as num
  ..img_src = json['img_src'] as String;

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'img_height': instance.img_height,
      'img_size': instance.img_size,
      'img_width': instance.img_width,
      'img_src': instance.img_src,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video()
  ..bvid = json['bvid'] as String
  ..aid = json['aid'] as num
  ..name = json['name'] as String
  ..mid = json['mid'] as num
  ..face = json['face'] as String
  ..tid = json['tid'] as num
  ..tname = json['tname'] as String
  ..copyright = json['copyright'] as num
  ..title = json['title'] as String
  ..desc = json['desc'] as String
  ..pic = json['pic'] as String
  ..tag = json['tag'] as String
  ..pubdate = json['pubdate'] as num
  ..duration = json['duration'] as String
  ..view = json['view'] as num
  ..danmaku = json['danmaku'] as num
  ..reply = json['reply'] as num
  ..favorite = json['favorite'] as num
  ..coin = json['coin'] as num
  ..share = json['share'] as num
  ..like = json['like'] as num
  ..score = json['score'] as num
  ..status = json['status'] as num
  ..created_at = json['created_at'] as num
  ..updated_at = json['updated_at'] as num;

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'bvid': instance.bvid,
      'aid': instance.aid,
      'name': instance.name,
      'mid': instance.mid,
      'face': instance.face,
      'tid': instance.tid,
      'tname': instance.tname,
      'copyright': instance.copyright,
      'title': instance.title,
      'desc': instance.desc,
      'pic': instance.pic,
      'tag': instance.tag,
      'pubdate': instance.pubdate,
      'duration': instance.duration,
      'view': instance.view,
      'danmaku': instance.danmaku,
      'reply': instance.reply,
      'favorite': instance.favorite,
      'coin': instance.coin,
      'share': instance.share,
      'like': instance.like,
      'score': instance.score,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

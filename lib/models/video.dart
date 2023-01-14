import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  Video();

  late String bvid;
  late num aid;
  late String name;
  late num mid;
  late String face;
  late num tid;
  late String tname;
  late num copyright;
  late String title;
  late String desc;
  late String pic;
  late String tag;
  late num pubdate;
  late String duration;
  late num view;
  late num danmaku;
  late num reply;
  late num favorite;
  late num coin;
  late num share;
  late num like;
  late num score;
  late num status;
  late num created_at;
  late num updated_at;
  
  factory Video.fromJson(Map<String,dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

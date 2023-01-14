import 'package:json_annotation/json_annotation.dart';
import "video.dart";
part 'videos.g.dart';

@JsonSerializable()
class Videos {
  Videos();

  late num page;
  late num numResults;
  late List<Video> result;
  
  factory Videos.fromJson(Map<String,dynamic> json) => _$VideosFromJson(json);
  Map<String, dynamic> toJson() => _$VideosToJson(this);
}

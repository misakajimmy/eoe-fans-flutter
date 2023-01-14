import 'package:json_annotation/json_annotation.dart';

part 'videosRequest.g.dart';

enum VideosRequestOrder {
  @JsonValue("pubdate")
  pubdate,
  @JsonValue("view")
  view,
  @JsonValue("score")
  score,
}

enum VideosCopyright {
  @JsonValue(1)
  Original,
  @JsonValue(2)
  Reproduced,
}

enum VideosRequestTname {
  @JsonValue('animation')
  animation,
  @JsonValue('music')
  music,
  @JsonValue('dance')
  dance,
  @JsonValue('game')
  game,
  @JsonValue('live')
  live,
  @JsonValue('delicacy')
  delicacy,
  @JsonValue('guichu')
  guichu,
  @JsonValue('other')
  other
}

@JsonSerializable()
class VideosRequest {
  VideosRequest();

  late VideosRequestOrder order;
  late num page;
  String? q;
  VideosCopyright? copyright;
  VideosRequestTname? tname;

  factory VideosRequest.fromJson(Map<String, dynamic> json) =>
      _$VideosRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VideosRequestToJson(this);
}

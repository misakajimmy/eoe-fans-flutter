import 'package:json_annotation/json_annotation.dart';

import 'member.dart';

part 'memberMap.g.dart';

enum MemberEnum {
  @JsonValue("zao")
  LUZAO,
  @JsonValue("wan")
  WANER,
  @JsonValue("mi")
  MINUO,
  @JsonValue("un")
  YOUEN,
  @JsonValue("mo")
  YUMO,
}

@JsonSerializable()
class MemberMap {
  MemberMap(this.members);

  Map<MemberEnum, Member> members;

  factory MemberMap.fromJson(Map<String, dynamic> json) => _$MemberMapFromJson(json);

  Map<String, dynamic> toJson() => _$MemberMapToJson(this);
}

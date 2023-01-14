import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

enum MemberEnum {
  @JsonValue("zao")
  zao,
  @JsonValue("wan")
  wan,
  @JsonValue("mi")
  mi,
  @JsonValue("un")
  un,
  @JsonValue("mo")
  mo,
}

@JsonSerializable()
class Member {
  Member(this.key ,this.lastName, this.firstName, this.bilibiliName, this.bilibiliUID,
      this.nickNames, this.color);

  String key;
  String lastName;
  String firstName;
  String bilibiliName;
  num bilibiliUID;
  List<String> nickNames;
  String color;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

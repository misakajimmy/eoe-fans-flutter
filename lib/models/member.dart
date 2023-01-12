import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  Member(this.lastName, this.firstName, this.bilibiliName, this.bilibiliUID,
      this.nickNames);

  String lastName;
  String firstName;
  String bilibiliName;
  String bilibiliUID;
  List<String> nickNames;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

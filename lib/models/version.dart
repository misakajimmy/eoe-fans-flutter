import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

@JsonSerializable()
class Version {
  Version();

  late String version;
  late String version_message;
  late Map<String,dynamic> download_url;
  late String updated_at;
  
  factory Version.fromJson(Map<String,dynamic> json) => _$VersionFromJson(json);
  Map<String, dynamic> toJson() => _$VersionToJson(this);
}

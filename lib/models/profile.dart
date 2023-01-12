import 'package:json_annotation/json_annotation.dart';
import "cacheConfig.dart";

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile({
    this.token,
    this.theme,
    this.cache,
    this.lastLogin,
    this.locale,
  });

  String? token;
  num? theme;
  CacheConfig? cache;
  String? lastLogin;
  String? locale;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

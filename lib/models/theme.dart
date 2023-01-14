import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'theme.g.dart';

@JsonSerializable()
class Theme {
  Theme();

  late String themeName;
  // late ThemeData themeData;

  factory Theme.fromJson(Map<String, dynamic> json) => _$ThemeFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeToJson(this);
}

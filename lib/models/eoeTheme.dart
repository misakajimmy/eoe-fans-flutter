import 'package:json_annotation/json_annotation.dart';

part 'eoeTheme.g.dart';

@JsonSerializable()
class EoeTheme {
  EoeTheme({required this.id, required this.name, required this.assetsPath,required this.filter});

  String id;
  String name;
  String assetsPath;
  String filter;

  factory EoeTheme.fromJson(Map<String, dynamic> json) =>
      _$EoeThemeFromJson(json);

  Map<String, dynamic> toJson() => _$EoeThemeToJson(this);
}

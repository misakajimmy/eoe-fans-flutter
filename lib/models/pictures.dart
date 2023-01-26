import 'package:json_annotation/json_annotation.dart';
import "dynamic.dart";

part 'pictures.g.dart';

enum PicturePageType {
  latest,
  recommend,
}

@JsonSerializable()
class Pictures {
  Pictures();

  late num page;
  late num total;
  late List<Dynamic> result;

  factory Pictures.fromJson(Map<String, dynamic> json) =>
      _$PicturesFromJson(json);

  Map<String, dynamic> toJson() => _$PicturesToJson(this);
}

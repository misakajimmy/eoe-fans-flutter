import 'package:json_annotation/json_annotation.dart';

part 'picture.g.dart';

@JsonSerializable()
class Picture {
  Picture();

  late num img_height;
  late num img_size;
  late num img_width;
  late String img_src;
  
  factory Picture.fromJson(Map<String,dynamic> json) => _$PictureFromJson(json);
  Map<String, dynamic> toJson() => _$PictureToJson(this);
}

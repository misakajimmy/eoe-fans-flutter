import 'package:json_annotation/json_annotation.dart';
import "picture.dart";
part 'dynamic.g.dart';

@JsonSerializable()
class Dynamic {
  Dynamic();

  late num dynamic_id;
  late List<Picture> pictures;
  late num sent_at;
  
  factory Dynamic.fromJson(Map<String,dynamic> json) => _$DynamicFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicToJson(this);
}

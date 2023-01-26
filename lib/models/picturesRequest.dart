import 'package:json_annotation/json_annotation.dart';

part 'picturesRequest.g.dart';

enum PicturesTopic {
  @JsonValue(29067608)
  zao(id: 29067608, label: 'zao'),
  @JsonValue(29069147)
  mi(id: 29069147, label: 'mi'),
  @JsonValue(28953983)
  wan(id: 28953983, label: 'wan'),
  @JsonValue(28948378)
  mo(id: 28948378, label: 'mo'),
  @JsonValue(28950030)
  un(id: 28950030, label: 'un'),
  @JsonValue(29156150)
  eoe(id: 29156150, label: 'eoe'),
  @JsonValue(0)
  all(id: 0, label: 'all');

  final int id;
  final String label;

  const PicturesTopic({
    required this.id,
    required this.label,
  });

  /// 解析从后台传来的值
  static PicturesTopic parse(int i) {
    return PicturesTopic.values[i];
  }
}

@JsonSerializable()
class PicturesRequest {
  PicturesRequest();

  late PicturesTopic topic_id;
  late num page;

  factory PicturesRequest.fromJson(Map<String, dynamic> json) =>
      _$PicturesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PicturesRequestToJson(this);
}

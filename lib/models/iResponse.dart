import 'package:json_annotation/json_annotation.dart';

part 'iResponse.g.dart';

enum IResponseCode {
  @JsonValue(0)
  OK,
  @JsonValue(400)
  ParamError,
  @JsonValue(4001)
  NeedLogin,
}

@JsonSerializable(genericArgumentFactories: true)
class IResponse<T> {
  IResponse();

  late IResponseCode code;
  late String message;
  late num ttl;
  T? data;

  factory IResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$IResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$IResponseToJson<T>(this, toJsonT);
}

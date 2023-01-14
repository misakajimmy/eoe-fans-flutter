// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IResponse<T> _$IResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    IResponse<T>()
      ..code = $enumDecode(_$IResponseCodeEnumMap, json['code'])
      ..message = json['message'] as String
      ..ttl = json['ttl'] as num
      ..data = _$nullableGenericFromJson(json['data'], fromJsonT);

Map<String, dynamic> _$IResponseToJson<T>(
  IResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': _$IResponseCodeEnumMap[instance.code]!,
      'message': instance.message,
      'ttl': instance.ttl,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

const _$IResponseCodeEnumMap = {
  IResponseCode.OK: 0,
  IResponseCode.ParamError: 400,
  IResponseCode.NeedLogin: 4001,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberMap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberMap _$MemberMapFromJson(Map<String, dynamic> json) => MemberMap(
      (json['members'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$MemberEnumEnumMap, k),
            Member.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$MemberMapToJson(MemberMap instance) => <String, dynamic>{
      'members':
          instance.members.map((k, e) => MapEntry(_$MemberEnumEnumMap[k]!, e)),
    };

const _$MemberEnumEnumMap = {
  MemberEnum.LUZAO: 'zao',
  MemberEnum.WANER: 'wan',
  MemberEnum.MINUO: 'mi',
  MemberEnum.YOUEN: 'un',
  MemberEnum.YUMO: 'mo',
};

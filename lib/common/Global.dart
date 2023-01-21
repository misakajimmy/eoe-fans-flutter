import 'dart:convert';

import 'package:eoe_fans/models/eoeTheme.dart';
import 'package:eoe_fans/models/member.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cacheConfig.dart';
import '../models/profile.dart';
import 'CacheObject.dart';

const _themes = <dynamic>[
  {
    'id': 'zao',
    'name': 'zao',
    'assetsPath': 'zao',
    'filter': 'emoji/gogo队.webp'
  },
  {'id': 'wan', 'name': 'wan', 'assetsPath': 'wan', 'filter': 'emoji/小莞熊.webp'},
  {'id': 'mo', 'name': 'mo', 'assetsPath': 'mo', 'filter': 'emoji/美人虞.webp'},
  {'id': 'un', 'name': 'un', 'assetsPath': 'un', 'filter': 'emoji/柚恩蜜.webp'},
  {'id': 'mi', 'name': 'mi', 'assetsPath': 'mi', 'filter': 'emoji/酷诺米.webp'}
];

const Map<MemberEnum, dynamic> membersJson = {
  MemberEnum.zao: {
    'key': 'zao',
    'lastName': '白',
    'firstName': '露早',
    'bilibiliName': '露早GOGO',
    'bilibiliUID': 1669777785,
    'nickNames': ['早早'],
    'color': '#3DFF9E',
  },
  MemberEnum.wan: {
    'key': 'wan',
    'lastName': '唐',
    'firstName': '莞儿',
    'bilibiliName': '莞儿睡不醒',
    'bilibiliUID': 1875044092,
    'nickNames': ['莞莞'],
    'color': '#1EAFE4',
  },
  MemberEnum.mo: {
    'key': 'mo',
    'lastName': '苏',
    'firstName': '虞莫',
    'bilibiliName': '虞莫MOMO',
    'bilibiliUID': 1811071010,
    'nickNames': ['莫莫'],
    'color': '#B77FDD',
  },
  MemberEnum.un: {
    'key': 'un',
    'lastName': '姜',
    'firstName': '柚恩',
    'bilibiliName': '柚恩不加糖',
    'bilibiliUID': 1795147802,
    'nickNames': ['柚柚'],
    'color': '#EB6346',
  },
  MemberEnum.mi: {
    'key': 'mi',
    'lastName': '安',
    'firstName': '米诺',
    'bilibiliName': '米诺高分少女',
    'bilibiliUID': 1778026586,
    'nickNames': ['大米'],
    'color': '#F068B0',
  }
};

class Global {
  static late SharedPreferences _prefs;
  static Profile profile = Profile();

  static Map<MemberEnum, Member> get members =>
      membersJson.map((key, value) => MapEntry(key, Member.fromJson(value)));

  static String theme = 'zao';

  //网络缓存对象
  static NetCache netCache = NetCache();

  //可选主题列表
  static List<EoeTheme> get themes =>
      _themes.map((e) => EoeTheme.fromJson(e)).toList();

  //是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static late PackageInfo packageInfo;

  //初始化全局信息，会在App启动时启动
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    var t = _prefs.getString("theme");
    print('theme');
    print(theme);
    if (t != null && t != '') {
      theme = t;
    }
    packageInfo = await PackageInfo.fromPlatform();
  }

  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));

  static saveTheme(String id) => _prefs.setString("theme", id);
}

import 'dart:convert';

import 'package:eoe_fans/models/eoeTheme.dart';
import 'package:eoe_fans/models/memberMap.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cacheConfig.dart';
import '../models/profile.dart';
import 'CacheObject.dart';

const _themes = <dynamic>[
  {
    'id': 'zao',
    'name': 'zao',
    'assetsPath': 'zao',
  },
  {
    'id': 'wan',
    'name': 'wan',
    'assetsPath': 'zao',
  },
  {
    'id': 'mo',
    'name': 'mo',
    'assetsPath': 'zao',
  },
  {
    'id': 'un',
    'name': 'un',
    'assetsPath': 'zao',
  },
  {
    'id': 'mi',
    'name': 'mi',
    'assetsPath': 'zao',
  }
];

const Map<String, dynamic> membersJson = {
  'zao': {
    'lastName': '白',
    'firstName': '露早',
    'bilibiliName': '露早GOGO',
    'bilibiliUID': 1669777785,
    'nickNames': ['早早'],
  },
  'wan': {
    'lastName': '唐',
    'firstName': '莞儿',
    'bilibiliName': '莞儿睡不醒',
    'bilibiliUID': 1875044092,
    'nickNames': [''],
  },
  'mo': {
    'lastName': '苏',
    'firstName': '虞莫',
    'bilibiliName': '虞莫MOMO',
    'bilibiliUID': 1811071010,
    'nickNames': ['莫莫'],
  },
  'un': {
    'lastName': '姜',
    'firstName': '柚恩',
    'bilibiliName': '柚恩不加糖',
    'bilibiliUID': 1795147802,
    'nickNames': ['柚柚'],
  },
  'mi': {
    'lastName': '安',
    'firstName': '米诺',
    'bilibiliName': '米诺高分少女',
    'bilibiliUID': 1778026586,
    'nickNames': ['大米'],
  }
};

class Global {
  static late SharedPreferences _prefs;
  static Profile profile = Profile();
  static MemberMap members = MemberMap.fromJson(membersJson);

  //网络缓存对象
  static NetCache netCache = NetCache();

  static String currentTheme = 'zao';

  //可选主题列表
  static List<EoeTheme> get themes => _themes.map((e) => EoeTheme.fromJson(e)).toList();

  //是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在App启动时启动
  static Future init() async {
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
  }

  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}

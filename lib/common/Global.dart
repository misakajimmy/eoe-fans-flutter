import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cacheConfig.dart';
import '../models/profile.dart';
import 'CacheObject.dart';

const Map<int, Color> myPink = {
  50: Color.fromRGBO(251, 114, 153, .1),
  100: Color.fromRGBO(251, 114, 153, .2),
  200: Color.fromRGBO(251, 114, 153, .3),
  300: Color.fromRGBO(251, 114, 153, .4),
  400: Color.fromRGBO(251, 114, 153, .5),
  500: Color.fromRGBO(251, 114, 153, .6),
  600: Color.fromRGBO(251, 114, 153, .7),
  700: Color.fromRGBO(251, 114, 153, .8),
  800: Color.fromRGBO(251, 114, 153, .9),
  900: Color.fromRGBO(251, 114, 153, 1),
};

const MaterialColor pink = MaterialColor(0xFFFB7299, myPink);

const _themes = <MaterialColor>[
  pink,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
];

class Global {
  static late SharedPreferences _prefs;
  static Profile profile = Profile();

  //网络缓存对象
  static NetCache netCache = NetCache();

  //可选主题列表
  static List<MaterialColor> get themes => _themes;

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

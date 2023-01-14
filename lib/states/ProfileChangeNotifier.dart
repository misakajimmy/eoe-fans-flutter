import 'package:flutter/cupertino.dart';

import '../common/Global.dart';
import '../models/profile.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  ProfileChangeNotifier();

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class ThemeModel extends ProfileChangeNotifier {
  // 获取当前主题，如果为设置主题，则默认使用zao主题
  String get theme => Global.themes
      .firstWhere((e) => e.id == Global.currentTheme, orElse: () => Global.themes.first).id;
  // 获取当前asset，如果为设置主题，则默认使用zao主题
  String get assets => Global.themes
      .firstWhere((e) => e.id == Global.currentTheme, orElse: () => Global.themes.first).assetsPath;

  set theme(String id) {
    if (id != Global.currentTheme) {
      Global.currentTheme = id;
      notifyListeners();
    }
  }
}

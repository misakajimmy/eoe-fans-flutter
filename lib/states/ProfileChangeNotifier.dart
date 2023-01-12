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
  // 获取当前主题，如果为设置主题，则默认使用粉色主题
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == _profile.theme, orElse: () => pink);

  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color[500]?.value;
      notifyListeners();
    }
  }
}

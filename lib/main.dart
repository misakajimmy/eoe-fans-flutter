import 'dart:io';

import 'package:eoe_fans/routes/mainPage.dart';
import 'package:eoe_fans/routes/setting/aboutUs.dart';
import 'package:eoe_fans/routes/setting/settingPage.dart';
import 'package:eoe_fans/routes/setting/settingTheme.dart';
import 'package:eoe_fans/routes/splashPage.dart';
import 'package:flutter/material.dart';
import 'package:eoe_fans/states/ProfileChangeNotifier.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'common/Global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  Global.init().then((e) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ThemeModel()),
        ],
        child: Consumer<ThemeModel>(
            builder: (BuildContext context, themeModel, Widget? child) {
          return MaterialApp(
            initialRoute: '/splash',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              '/main': (BuildContext context) => MainPage(),
              '/splash': (BuildContext context) => SplashScreen(),
              '/setting': (BuildContext context) => const SettingPage(),
              '/theme': (BuildContext context) => const SettingTheme(),
              '/about': (BuildContext context) => const AboutUs(),
            },
          );
        }));
  }
}

import 'package:eoe_fans/common/Global.dart';
import 'package:eoe_fans/models/member.dart';
import 'package:eoe_fans/common/Global.dart';
import 'package:eoe_fans/states/ProfileChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '设置',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          height: double.maxFinite,
          child: Image(
            image: AssetImage(
                'assets/${Provider.of<ThemeModel>(context).assets}/head_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('常规'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.color_lens_outlined),
                title: Text('主题'),
                value: Text(Global
                        .members[Provider.of<ThemeModel>(context).themeMember]
                        ?.firstName ??
                    ''),
                trailing: Icon(Icons.keyboard_arrow_right),
                onPressed: (BuildContext context) {
                  Navigator.pushNamed(context, '/theme');
                },
              ),

              // SettingsTile.switchTile(
              //   onToggle: (value) {},
              //   initialValue: true,
              //   leading: Icon(Icons.format_paint),
              //   title: Text('Enable custom theme'),
              // ),
            ],
          ),
          SettingsSection(
            title: Text('关于'),
            tiles: [
              SettingsTile.navigation(
                leading: Icon(Icons.update),
                title: Text('检查版本'),
                value: Text(
                    '当前版本: ${Global.packageInfo.version}'),
                // onPressed: (BuildContext context) {
                //   Navigator.pushNamed(context, '/theme');
                // },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.info_outline),
                title: Text('关于我们'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onPressed: (BuildContext context) {
                  Navigator.pushNamed(context, '/about');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

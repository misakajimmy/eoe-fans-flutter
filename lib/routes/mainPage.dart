import 'package:eoe_fans/common/Api.dart';
import 'package:eoe_fans/common/CompareVersion.dart';
import 'package:eoe_fans/common/Global.dart';
import 'package:eoe_fans/routes/music/musicPage.dart';
import 'package:eoe_fans/routes/picture/picturePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hgg_app_upgrade/hgg_app_upgrade.dart';
import 'package:provider/provider.dart';

import '../states/ProfileChangeNotifier.dart';
import 'video/videoPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _bodyList = [
    const VideoPage(),
    const PicturePage(),
    const MusicPage(),
  ];

  Future<AppUpgradeInfo?> _checkAppInfo() async {
    var r = await Api().version();

    if (r.version != '') {
      if (haveNewVersion(r.version, Global.packageInfo.version)) {
        return AppUpgradeInfo(
          title: '新版本 V' + r.version,
          contents: r.version_message.split('\n'),
          apkDownloadUrl: r.download_url['android'],
          force: false,
        );
      }
    }
    return null;
  }

  @override
  void initState() {
    AppUpgrade.appUpgrade(context, _checkAppInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _bodyList,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/${Provider.of<ThemeModel>(context).assets}/tail_bg.png'),
                        fit: BoxFit.fill),
                    color: Colors.transparent),
                child: BottomNavigationBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.video_library_outlined),
                      label: '视频',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.image),
                      label: '图片',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.library_music),
                      label: '音乐',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

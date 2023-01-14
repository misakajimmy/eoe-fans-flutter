import 'package:eoe_fans/routes/music/musicPage.dart';
import 'package:eoe_fans/routes/picture/picturePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _bodyList,
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/${Provider.of<ThemeModel>(context).assets}/tail_bg.png'),
                    fit: BoxFit.fill),
                color: Colors.transparent),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.image),
                  label: '视频',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.image),
                  backgroundColor: Colors.transparent,
                  label: '图片',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_music),
                  label: '音乐',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            )));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
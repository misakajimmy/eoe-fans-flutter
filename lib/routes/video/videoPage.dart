import 'package:eoe_fans/routes/video/videoNewYear.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/ProfileChangeNotifier.dart';
import 'videoList.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/setting');
            },
            child: Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: const CircleAvatar(
                child: ClipOval(
                  child: Image(
                    image: AssetImage('assets/eoe.webp'),
                  ),
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: Container(
            width: 300,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: const TabBar(
              tabs: [
                Tab(
                  text: "二创",
                ),
                Tab(
                  text: "拜年纪",
                ),
                Tab(
                  text: "切片",
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
              ),
              onPressed: () {},
            ),
          ],
          flexibleSpace: Container(
            height: double.maxFinite,
            child: Image(
              image: AssetImage(
                  'assets/${Provider.of<ThemeModel>(context).assets}/head_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 4, right: 4, top: 8),
          child: const TabBarView(
            children: [
              VideoList(origin: true),
              VideoNewYear(),
              VideoList(origin: false),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:eoe_fans/models/pictures.dart';
import 'package:eoe_fans/routes/picture/pictureList.dart';
import 'package:eoe_fans/states/ProfileChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PicturePage extends StatefulWidget {
  const PicturePage({Key? key}) : super(key: key);

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            padding: const EdgeInsets.only(left: 20, right: 40),
            child: const TabBar(
              tabs: [
                Tab(
                  text: "推荐",
                ),
                Tab(
                  text: "最新",
                ),
              ],
            ),
          ),
          actions: [
            // IconButton(
            //   icon: const Icon(
            //     Icons.search,
            //   ),
            //   onPressed: () {},
            // ),
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
          padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 40),
          child: const TabBarView(
            children: [
              PictureList(pageType: PicturePageType.recommend),
              PictureList(pageType: PicturePageType.latest),
            ],
          ),
        ),
      ),
    );
  }
}

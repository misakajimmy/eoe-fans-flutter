import 'dart:ffi';

import 'package:eoe_fans/common/Api.dart';
import 'package:eoe_fans/models/video.dart';
import 'package:eoe_fans/models/videos.dart';
import 'package:eoe_fans/models/videosRequest.dart';
import 'package:eoe_fans/routes/video/videoSearchItem.dart';
import 'package:eoe_fans/states/ProfileChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoSearchPage extends StatefulWidget {
  const VideoSearchPage({Key? key}) : super(key: key);

  @override
  State<VideoSearchPage> createState() => _VideoSearchPageState();
}

class _VideoSearchPageState extends State<VideoSearchPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String searchString = '';

  int _page = 0;
  List<Video> videoList = [];

  _searchVideo({required bool refresh}) async {
    if (refresh) {
      _page = 0;
      videoList = [];
    }
    _page++;
    if (searchString != '') {
      Videos videos = await Api(context).videos(
        VideosRequest()
          ..order = VideosRequestOrder.score
          ..page = _page
          ..q = 'tag.' + searchString,
      );
      if (videos.numResults == videoList.length) {
        Fluttertoast.showToast(
          msg: "到头了喵",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.3),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      if (videos.result.length != 0) {
        setState(() {
          videoList = [...videoList, ...videos.result];
        });
      }
    }
  }

  void _onRefresh() async {
    // monitor network fetch
    await _searchVideo(refresh: true);
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await _searchVideo(refresh: false);
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 32,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 2),
            // width: 120,
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.search,
              onChanged: (v) {
                searchString = v;
              },
              onSubmitted: (v) {
                _searchVideo(refresh: true);
              },
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchVideo(refresh: true);
            },
            child: Container(
              // color: Colors.amber,
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                '搜索',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          height: double.maxFinite,
          child: Image(
            image: AssetImage(
                'assets/${Provider.of<ThemeModel>(context).assets}/head_tab_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("上拉加载");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("加载失败！点击重试！");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("松手,加载更多!");
          } else {
            body = Text("没有更多数据了!");
          }
          return Container(
            child: Center(child: body),
          );
        }),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 120,
              child: VideoSearchItem(video: videoList[i]),
            ),
            // child: Center(
            //   child: Image(
            //     image: CachedNetworkImageProvider(dynamicList[i].pictures[0].img_src),
            //     fit: BoxFit.fitWidth,
            //     width: double.infinity,
            //   ),
            // ),
          ),
          itemCount: videoList.length,
        ),
      ),
    );
  }
}

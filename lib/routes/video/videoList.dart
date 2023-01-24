import 'dart:math';
import 'package:eoe_fans/common/Api.dart';
import 'package:eoe_fans/models/member.dart';
import 'package:eoe_fans/models/video.dart';
import 'package:eoe_fans/models/videos.dart';
import 'package:eoe_fans/models/videosRequest.dart';
import 'package:eoe_fans/routes/video/videoListItem.dart';
import 'package:eoe_fans/routes/video/videoMemberFilter.dart';
import 'package:eoe_fans/common/Global.dart';
import 'package:eoe_fans/routes/video/videoSwiper.dart';
import 'package:eoe_fans/states/ProfileChangeNotifier.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key, this.origin}) : super(key: key);

  final bool? origin;

  @override
  State<VideoList> createState() => _VideoListState()..origin = origin;
}

class _VideoListState extends State<VideoList> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  late final bool? origin;

  int _page = 0;
  MemberEnum? _memberFilter;
  VideosRequestOrder _order = VideosRequestOrder.view;

  bool _loading = false;
  List<Video> videoList = [];

  @override
  void initState() {
    // print('object');
    _getVideos();
    super.initState();
  }

  _getVideos() async {
    setState(() {
      _loading = true;
      _page++;
    });
    Videos videos = await Api(context).videos(VideosRequest()
      ..order = _order
      ..page = _page
      ..q = _memberFilter == null
          ? null
          : 'tag.${Global.members[_memberFilter]?.firstName ?? ''}+${Global.members[_memberFilter]?.bilibiliName ?? ''}'
      ..copyright = origin == null
          ? null
          : origin!
              ? VideosCopyright.Original
              : VideosCopyright.Reproduced);
    if (videos.result.length != 0) {
      setState(() {
        videoList = [...videoList, ...videos.result];
        _loading = false;
      });
    } else {
      await Future.delayed(Duration(seconds: 5), () {
        _getVideos();
      });
    }
  }

  _reloadVideos({int? page}) async {
    setState(() {
      videoList = [];
      _page = page ?? 0;
    });
    await _getVideos();
  }

  @override
  Widget build(BuildContext context) {
    var videos = videoList
        .map((video) => StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: VideoListItem(
                video: video,
              ),
            ))
        .toList();

    videos.insert(
      0,
      StaggeredGridTile.count(
        crossAxisCellCount: 4,
        mainAxisCellCount: 0.5,
        child: Container(
          margin: const EdgeInsets.only(left: 4),
          child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_order != VideosRequestOrder.view) {
                        setState(() {
                          _order = VideosRequestOrder.view;
                          _reloadVideos();
                        });
                      }
                    },
                    child: Text(
                      '最多播放',
                      style: TextStyle(
                        color: _order != VideosRequestOrder.view
                            ? Colors.black54
                            : Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: GestureDetector(
                      onTap: () {
                        if (_order != VideosRequestOrder.pubdate) {
                          setState(() {
                            _order = VideosRequestOrder.pubdate;
                            _reloadVideos();
                          });
                        }
                      },
                      child: Text(
                        '最新播放',
                        style: TextStyle(
                          color: _order != VideosRequestOrder.pubdate
                              ? Colors.black54
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );

    videos.insert(
      0,
      StaggeredGridTile.count(
        crossAxisCellCount: 4,
        mainAxisCellCount: 0.8,
        child: VideoMemberFilter(
          updateFilterMember: (MemberEnum? value) {
            setState(() {
              _memberFilter = value;
              _reloadVideos();
            });
          },
        ),
      ),
    );
    videos.insert(
      0,
      const StaggeredGridTile.count(
        crossAxisCellCount: 4,
        mainAxisCellCount: 9 / 4,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: VideoSwiper(),
        ),
      ),
    );
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scrollbar(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              // double progress = notification.metrics.pixels /
              //     notification.metrics.maxScrollExtent;
              // print("${(progress * 100).toInt()}%");
              // print(notification.metrics.maxScrollExtent - notification.metrics.pixels);
              //重新构建
              setState(() {
                if (notification.metrics.maxScrollExtent -
                            notification.metrics.pixels <
                        1200 &&
                    notification.metrics.maxScrollExtent -
                        notification.metrics.pixels >
                        0 &&
                    !_loading) {
                  print(notification.metrics.maxScrollExtent - notification.metrics.pixels);
                  _getVideos();
                }
              });
              // print("BottomEdge: ${notification.metrics.extentAfter == 0}");
              return false;
              //return true; //放开此行注释后，进度条将失效
            },
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                children: videos,
              ),
            ),
          ),
        ),
        _loading
            ? Positioned(
                top: 16,
                child: Container(
                  width: 64,
                  height: 64,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                    gradient: RadialGradient(
                      colors: [
                        HexColor(Global
                                .members[Provider.of<ThemeModel>(context)
                                    .themeMember]
                                ?.color ??
                            '#FFFFFF'),
                        Color.fromRGBO(255, 255, 255, 0),
                      ],
                      radius: 0.6,
                    ),
                  ),
                  child: Image(
                    image: AssetImage(
                        'assets/${Provider.of<ThemeModel>(context).assets}/loading.gif'),
                    fit: BoxFit.cover,
                  ),
                ))
            : Container()
      ],
    );
  }
}

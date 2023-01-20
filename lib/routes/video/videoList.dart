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
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
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

  int _page = -1;
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
    setState(() {
      videoList = [...videoList, ...videos.result];
      _loading = false;
    });
  }

  _reloadVideos({int? page}) async {
    setState(() {
      videoList = [];
      _page = page ?? -1;
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
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          // double progress = notification.metrics.pixels /
          //     notification.metrics.maxScrollExtent;
          // print("${(progress * 100).toInt()}%");
          print(notification.metrics.maxScrollExtent - notification.metrics.pixels);
          //重新构建
          setState(() {
            if (notification.metrics.maxScrollExtent - notification.metrics.pixels < 1000 && !_loading) {
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
    );
  }
}

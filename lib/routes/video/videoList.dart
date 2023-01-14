import 'package:eoe_fans/common/Api.dart';
import 'package:eoe_fans/models/member.dart';
import 'package:eoe_fans/models/video.dart';
import 'package:eoe_fans/models/videos.dart';
import 'package:eoe_fans/models/videosRequest.dart';
import 'package:eoe_fans/routes/video/videoListItem.dart';
import 'package:eoe_fans/routes/video/videoMemberFilter.dart';
import 'package:eoe_fans/common/Global.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key, this.origin}) : super(key: key);

  final bool? origin;

  @override
  State<VideoList> createState() => _VideoListState()..origin = origin;
}

class _VideoListState extends State<VideoList> {
  late final bool? origin;

  int _page = -1;
  MemberEnum? _memberFilter;

  bool _loading = false;
  List<Video> videoList = [];

  @override
  void initState() {
    print('object');
    _getVideos();
    super.initState();
  }

  _getVideos() async {
    setState(() {
      _loading = true;
      _page++;
    });
    Videos videos = await Api(context).videos(VideosRequest()
      ..order = VideosRequestOrder.score
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

  _reloadVideos() async {
    setState(() {
      videoList = [];
      _page = -1;
      _getVideos();
    });
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
    return Scrollbar(
        child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              double progress = notification.metrics.pixels /
                  notification.metrics.maxScrollExtent;
              print("${(progress * 100).toInt()}%");
              //重新构建
              setState(() {
                if (progress > 0.9 && !_loading) {
                  _getVideos();
                }
              });
              print("BottomEdge: ${notification.metrics.extentAfter == 0}");
              return false;
              //return true; //放开此行注释后，进度条将失效
            },
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  children: videos),
            )));
  }
}

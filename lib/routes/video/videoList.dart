import 'package:eoe_fans/common/Api.dart';
import 'package:eoe_fans/models/video.dart';
import 'package:eoe_fans/models/videos.dart';
import 'package:eoe_fans/models/videosRequest.dart';
import 'package:eoe_fans/routes/video/videoListItem.dart';
import 'package:flutter/material.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key, this.origin}) : super(key: key);

  final bool? origin;

  @override
  State<VideoList> createState() => _VideoListState()..origin = origin;
}

class _VideoListState extends State<VideoList> {
  late final bool? origin;

  int _len = 100;
  int _page = -1;
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

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            double progress = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
            //重新构建
            setState(() {
              print("${(progress * 100).toInt()}%");
              if (progress > 0.95 && !_loading) {
                _getVideos();
              }
            });
            print("BottomEdge: ${notification.metrics.extentAfter == 0}");
            return false;
            //return true; //放开此行注释后，进度条将失效
          },
          child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 360.0, childAspectRatio: 1 //宽高比为2
                ),
            children: List.generate(videoList.length, (index) {
              return Container(
                child: VideoListItem(
                  video: videoList[index],
                ),
              );
            }),
          )),
    );
  }
}

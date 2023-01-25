import 'package:eoe_fans/common/Api.dart';
import 'package:eoe_fans/models/video.dart';
import 'package:eoe_fans/models/videos.dart';
import 'package:eoe_fans/models/videosRequest.dart';
import 'package:eoe_fans/routes/video/videoListItem.dart';
import 'package:eoe_fans/common/Global.dart';
import 'package:eoe_fans/routes/video/videoSwiperNewYear.dart';
import 'package:eoe_fans/states/ProfileChangeNotifier.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoNewYear extends StatefulWidget {
  const VideoNewYear({Key? key, this.origin}) : super(key: key);

  final bool? origin;

  @override
  State<VideoNewYear> createState() => _VideoNewYearState()..origin = origin;
}

const List<Map<String, dynamic>> newYearList = [
  {"index": 0, "节目类型": "录播", "节目名": "2023EOE拜年纪【直播录像】", "BV": "BV168411w7Q4"},
  {"index": 1, "节目类型": "视频混剪", "节目名": "《她们的故事》", "BV": "BV1oR4y1a7Aq"},
  {"index": 2, "节目类型": "原创音乐", "节目名": "《梦待续》", "BV": "BV1JP4y1r736"},
  {
    "index": 3,
    "节目类型": "舞蹈翻跳",
    "节目名": "《蛞蝓老师舞台首秀？Mr.Love团体首翻！》",
    "BV": "BV1wD4y1n7cP"
  },
  {"index": 4, "节目类型": "相声小品", "节目名": "《入坑》", "BV": "BV1r3411R7tE"},
  {"index": 5, "节目类型": "MMD", "节目名": "还是你的笑容最可爱", "BV": "BV1Ys4y1x7y4"},
  {"index": 6, "节目类型": "填词翻唱", "节目名": "《Switch to me》", "BV": "BV1MA411d79g"},
  {"index": 7, "节目类型": "MAD·AMV", "节目名": "《精卫》", "BV": "BV1nD4y1n7bY"},
  {"index": 8, "节目类型": "MMD动画", "节目名": "《Dream of you》", "BV": "BV1UM411t7Kj"},
  {"index": 9, "节目类型": "填词翻调", "节目名": "《褒贬太假，只剩形容》", "BV": "BV1g3411R7oi"},
  {"index": 10, "节目类型": "原创音乐剧", "节目名": "《米诺幻想纪行》", "BV": "BV1Jd4y157Ha"},
  {"index": 11, "节目类型": "鬼畜剧场", "节目名": "《V圈异闻录2》", "BV": "BV1sM411t7vB"},
  {"index": 12, "节目类型": "填词翻调", "节目名": "《海王组曲》", "BV": "BV1Dv4y1r7Jt"},
  {"index": 13, "节目类型": "MC喊麦", "节目名": "《茄子咒》", "BV": "BV1gG4y197aK"},
  {"index": 14, "节目类型": "混剪手书", "节目名": "《真相是假》", "BV": "BV1bs4y1t7ES"},
  {"index": 15, "节目类型": "MAD·AMV", "节目名": "《大吉》", "BV": "BV1gT41127HK"},
  {"index": 16, "节目类型": "填词翻唱", "节目名": "《披星戴月的想你》", "BV": "BV1k84y1j7yo"},
  {"index": 17, "节目类型": "乐器独奏", "节目名": "《小提琴串烧》", "BV": "BV1N8411w7vf"},
  {
    "index": 18,
    "节目类型": "交响乐",
    "节目名": "在维也纳金色大厅演奏《Mr. Love》",
    "BV": "BV16M411t7w9"
  },
  {"index": 19, "节目类型": "创意短片", "节目名": "《拜年纪公益广告》", "BV": "BV1N24y1r7UY"},
  {"index": 20, "节目类型": "舞蹈翻跳", "节目名": "《采薇》", "BV": "BV1mv4y1r7Rs"},
  {"index": 21, "节目类型": "舞蹈翻跳", "节目名": "《Mr.Love整活翻跳》", "BV": "BV1Cd4y1j7M8"},
  {"index": 22, "节目类型": "舞蹈翻跳", "节目名": "《Love Shot》", "BV": "BV1xM411t7Uf"},
  {"index": 23, "节目类型": "音MAD", "节目名": "《Think of EOE》", "BV": "BV11D4y1n7Ro"},
  {"index": 24, "节目类型": "预告PV", "节目名": "《神秘企划？》", "BV": "BV16Y411D7Vj"},
  {"index": 25, "节目类型": "填词翻调", "节目名": "《海海海》", "BV": "BV12s4y1x76T"},
  {"index": 26, "节目类型": "填词翻调", "节目名": "《海王颂》", "BV": "BV1p8411w7Uk"},
  {"index": 27, "节目类型": "MC展示", "节目名": "GOGO城-《银河系》", "BV": "BV1UR4y1a7sy"},
  {"index": 28, "节目类型": "游戏视频", "节目名": "《大家好啊，我是蓄力斧》", "BV": "BV17P4y1r7By"},
  {"index": 29, "节目类型": "鬼畜调教", "节目名": "《爆！爆！爆！》", "BV": "BV1qD4y1n7HE"},
  {"index": 30, "节目类型": "动画手书", "节目名": "《你先别急》", "BV": "BV1184y1j7iv"},
  {
    "index": 31,
    "节目类型": "原创音乐",
    "节目名": "《Hold the Supreme Crown》",
    "BV": "BV1VD4y1n7Vq"
  },
  {"index": 32, "节目类型": "动画手书", "节目名": "《百京冬日相会》", "BV": "BV1JA411k7sh"},
  {
    "index": 33,
    "节目类型": "MAD·AMV",
    "节目名": "《安许白头诺，又忘青丝恩》",
    "BV": "BV14T41127Qj"
  },
  {
    "index": 34,
    "节目类型": "动画手书",
    "节目名": "《我用EOE摆烂了你的AE作业》",
    "BV": "BV18G4y1F7J3"
  },
  {"index": 35, "节目类型": "GMV", "节目名": "《只狼xEOE》", "BV": "BV1Tx4y1M7yb"},
  {"index": 36, "节目类型": "填词翻唱", "节目名": "《米口脱险》", "BV": "BV19A411R7Nc"},
  {"index": 37, "节目类型": "VLOG", "节目名": "《年夜饭》", "BV": "BV1JM411q7HP"},
  {"index": 38, "节目类型": "像素动画", "节目名": "《贪吃惹的祸》", "BV": "BV1fy4y1R7w1"},
  {"index": 39, "节目类型": "手书", "节目名": "朝你大胯捏一把", "BV": "BV17d4y1574d"},
  {"index": 40, "节目类型": "Cosplay MV", "节目名": "《暧昧さ回避》", "BV": "BV1484y187oa"},
  {"index": 41, "节目类型": "创意短片", "节目名": "《好运来》", "BV": "BV13D4y1n7m6"},
  {"index": 42, "节目类型": "动画手书", "节目名": "《虞莫是姬佬还是偶像》", "BV": "BV1c8411w7sW"},
  {"index": 43, "节目类型": "GMV", "节目名": "《无所谓，姐会武功》", "BV": "BV1C84y1j7M7"},
  {"index": 44, "节目类型": "动画手书", "节目名": "《尽管我们手中空无一物》", "BV": "BV1pY411X7tB"},
  {"index": 45, "节目类型": "创意短片", "节目名": "《慢 摇 女 团》", "BV": "BV1GM411q7Ft"},
  {"index": 46, "节目类型": "实体手书", "节目名": "《女团内战》", "BV": "BV1F8411w7Vw"},
  {
    "index": 47,
    "节目类型": "鬼畜剧场",
    "节目名": "《EOE猫和老鼠-爱跳舞的茄子》",
    "BV": "BV1VR4y1Y7gr"
  },
  {"index": 48, "节目类型": "MAD", "节目名": "《姜柚恩情感大作战》", "BV": "BV1H3411o7di"},
  {"index": 49, "节目类型": "动画手书", "节目名": "《猜猜我是谁》", "BV": "BV13d4y157mv"},
  {
    "index": 50,
    "节目类型": "动画手书",
    "节目名": "《Fly me to the star》",
    "BV": "BV1hs4y1x7pK"
  },
  {"index": 51, "节目类型": "MAD·AMV", "节目名": "《我真的爱你》", "BV": "BV1iD4y1n7zN"},
  {"index": 52, "节目类型": "音MAD", "节目名": "《打打打打打打打打打打》", "BV": "BV1eD4y1n7kQ"},
  {"index": 53, "节目类型": "原创音乐", "节目名": "《粉红色水汽》", "BV": "BV1Xv4y1C7GL"},
  {"index": 54, "节目类型": "宣发短片", "节目名": "《APP产品发布会》", "BV": "BV1tx4y1M7Gz"},
  {"index": 55, "节目类型": "相声小品", "节目名": "《打工奇遇》", "BV": "BV1284y1j7hQ"},
  {"index": 56, "节目类型": "翻唱混剪", "节目名": "《爱的飞行日记》", "BV": "BV1xT41127A7"},
  {"index": 57, "节目类型": "wota艺", "节目名": "《打上花火》", "BV": "BV1Tx4y1M7Am"},
  {"index": 58, "节目类型": "团曲合唱", "节目名": "《量眼E黑》", "BV": "BV1AG4y1c7z5"},
  {"index": 59, "节目类型": "视频混剪", "节目名": "《E起度过的2022》", "BV": "BV1tA411k738"}
];

class _VideoNewYearState extends State<VideoNewYear> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  late final bool? origin;

  int _page = 1;
  VideosRequestOrder _order = VideosRequestOrder.pubdate;

  bool _loading = false;
  List<Video> videoNewYear = [];

  @override
  void initState() {
    _getVideos();
    super.initState();
  }

  _getVideos() async {
    setState(() {
      _loading = true;
    });
    List<Video> getVideos = [];
    while (_page <= 3) {
      Videos videos = await Api(context).videos(VideosRequest()
        ..order = _order
        ..page = _page
        ..q = 'tag.EOE拜年纪');
      if (videos.result.length != 0) {
        getVideos = [...getVideos, ...videos.result];
        getVideos.sort((a, b) {
          var aId = 99;
          var bId = 99;
          try {
            aId =
                newYearList.firstWhere((e) => e['BV'] == a.bvid)['index'] ?? 99;
          } catch (e) {}
          try {
            bId =
                newYearList.firstWhere((e) => e['BV'] == b.bvid)['index'] ?? 99;
          } catch (e) {}
          return aId - bId;
        });
      } else {
        await Future.delayed(Duration(seconds: 5), () {
          _getVideos();
        });
      }
      _page++;
    }
    setState(() {
      _loading = false;
      videoNewYear = getVideos;
    });
  }

  @override
  Widget build(BuildContext context) {
    var videos = videoNewYear.map((video) => StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: VideoListItem(
            video: video,
          ),
        )).toList();

    videos.insert(
      0,
      const StaggeredGridTile.count(
        crossAxisCellCount: 4,
        mainAxisCellCount: 9 / 4,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: VideoSwiperNewYear(),
        ),
      ),
    );
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scrollbar(
          child: NotificationListener<ScrollNotification>(
            // onNotification: (ScrollNotification notification) {
            //   // double progress = notification.metrics.pixels /
            //   //     notification.metrics.maxScrollExtent;
            //   // print("${(progress * 100).toInt()}%");
            //   // print(notification.metrics.maxScrollExtent - notification.metrics.pixels);
            //   //重新构建
            //   setState(() {
            //     if (notification.metrics.maxScrollExtent -
            //                 notification.metrics.pixels <
            //             1200 &&
            //         notification.metrics.maxScrollExtent -
            //                 notification.metrics.pixels >
            //             0 &&
            //         !_loading) {
            //       print(notification.metrics.maxScrollExtent -
            //           notification.metrics.pixels);
            //       _getVideos();
            //     }
            //   });
            //   // print("BottomEdge: ${notification.metrics.extentAfter == 0}");
            //   return false;
            //   //return true; //放开此行注释后，进度条将失效
            // },
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

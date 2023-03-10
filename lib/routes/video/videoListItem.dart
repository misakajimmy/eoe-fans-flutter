import 'package:cached_network_image/cached_network_image.dart';
import 'package:eoe_fans/common/Time.dart';
import 'package:eoe_fans/models/video.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoListItem extends StatelessWidget {
  const VideoListItem({Key? key, required this.video}) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var _url = 'bilibili://video/' + video.bvid;
        if (!await launchUrl(Uri.parse(_url))) {
          throw 'Could not launch $_url';
        }
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                  flex: 5,
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: double.maxFinite,
                          child: Image(
                            image: CachedNetworkImageProvider(video.pic),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: new BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, .3),
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin:  Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.ondemand_video_sharp,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Text(
                                        video.view < 10000
                                            ? video.view.toString()
                                            : '${(video.view / 10000).toStringAsFixed(1)}???',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: const Icon(
                                        Icons.list_alt,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Text(
                                        video.danmaku < 10000
                                            ? video.danmaku.toString() + '???'
                                            : '${(video.danmaku / 10000).toStringAsFixed(2)}???',
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Text(
                                        SecondToDate(int.parse(video.duration)),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          video.title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 1, right: 1, top: 1, bottom: 0),
                              decoration: BoxDecoration(
                                //?????????????????? ?????? ???????????????????????? ???Container height ?????????
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                //??????????????????
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: Text(
                                'UP',
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Center(
                                child: Text(
                                  video.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

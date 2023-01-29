import 'package:cached_network_image/cached_network_image.dart';
import 'package:eoe_fans/common/Time.dart';
import 'package:eoe_fans/models/video.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoSearchItem extends StatelessWidget {
  const VideoSearchItem({Key? key, required this.video}) : super(key: key);
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
      child: Container(
        padding: EdgeInsets.all(10),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Stack(
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
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          color: Color.fromRGBO(0, 0, 0, .3),
                        ),
                        child: Text(
                          SecondToDate(int.parse(video.duration)),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        video.title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 1, right: 1, top: 1, bottom: 0),
                              decoration: BoxDecoration(
                                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                //设置四周边框
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
                              child: Text(
                                video.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.ondemand_video_sharp,
                              size: 12,
                              color: Colors.grey,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Text(
                                video.view < 10000
                                    ? video.view.toString()
                                    : '${(video.view / 10000).toStringAsFixed(1)}万',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: const Icon(
                                Icons.list_alt,
                                size: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Text(
                                video.danmaku < 10000
                                    ? video.danmaku.toString() + '条'
                                    : '${(video.danmaku / 10000).toStringAsFixed(2)}万',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

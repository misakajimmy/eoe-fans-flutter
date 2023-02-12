import 'package:cached_network_image/cached_network_image.dart';
import 'package:eoe_fans/routes/picture/pictureDetail.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';

class PictureSwiper extends StatelessWidget {
  const PictureSwiper({required this.images, this.dynamicId, Key? key})
      : super(key: key);
  final String? dynamicId;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.heavyImpact();
        // showMaterialModalBottomSheet(
        //   context: context,
        //   builder: (context) => Container(),
        // );
        print('long press');
      },
      child: Stack(
        children: [
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              var image = CachedNetworkImageProvider(images[index]);
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PictureDetail(index: index, images: images);
                            },
                          ),
                        );
                      },
                      child: Container(
                        child: ExtendedImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, .3),
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
            itemCount: images.length,
            onTap: (int index) async {},
            pagination: const SwiperPagination(
              alignment: Alignment.bottomLeft,
              builder: DotSwiperPaginationBuilder(
                color: Colors.white30, // 其他点的颜色
                activeColor: Colors.white,
                space: 2, // 点与点之间的距离
                activeSize: 15, // 当前点的大小
              ),
            ),
            autoplay: false,
          ),
          Positioned(
            bottom: -4,
            right: 8,
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.white,
              ),
              onPressed: () async {
                if (dynamicId != null) {
                  var _url = 'bilibili://following/detail/' + dynamicId!;
                  if (!await launchUrl(Uri.parse(_url))) {
                    throw 'Could not launch $_url';
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

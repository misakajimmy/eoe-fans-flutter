import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';

const images = [
  'http://i1.hdslb.com/bfs/archive/ca89454a004899718dcdc291459ed449a684e19c.jpg',
  'http://i1.hdslb.com/bfs/archive/6d5257dac103caf8cbd286a556a21aaf21246fea.jpg',
];

const urls = [
  'bilibili://video/BV168411w7Q4',
  'bilibili://video/BV1tx4y1M7Gz',
];

class VideoSwiperNewYear extends StatelessWidget {
  const VideoSwiperNewYear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Image(
            image: CachedNetworkImageProvider(images[index]),
            fit: BoxFit.fill,
          ),
        );
      },
      itemCount: images.length,
      onTap: (int index) async {
        if (!await launchUrl(Uri.parse(urls[index]))) {
          throw 'Could not launch ${urls[index]}';
        }
      },
      pagination: const SwiperPagination(
        alignment: Alignment.bottomRight,
        builder: DotSwiperPaginationBuilder(
            color: Colors.black12, // 其他点的颜色
            activeColor: Colors.white,
            space: 2, // 点与点之间的距离
            activeSize: 15 // 当前点的大小
            ),
      ),
      autoplay: true,
    );
  }
}

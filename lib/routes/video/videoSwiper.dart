import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';

const images = [
  'assets/banner1.jpg',
  'assets/banner2.png',
  'assets/banner3.png',
];

const urls = [
  'https://b23.tv/GI9EDCl',
  'bilibili://video/BV1Pv4y1C7TE',
  'https://b23.tv/kI0MBkx'
];

class VideoSwiper extends StatelessWidget {
  const VideoSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Image(
            image: AssetImage(images[index]),
            fit: BoxFit.fill,
          ),
        );
      },
      itemCount: images.length,
      onTap: (int index) async {
        print(index);
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

const images = [
  'https://i0.hdslb.com/bfs/banner/8ad45f463da4c6411b94c960a713dd72bbf97657.jpg',
  'https://i0.hdslb.com/bfs/banner/023d359000172a213d7a5537295e4236fca63004.png',
  'https://i0.hdslb.com/bfs/banner/6c87d994adab02603270d84c93bdc99dab6e64be.jpg'
];

class VideoSwiper extends StatelessWidget {
  const VideoSwiper({Key? key}) : super(key: key);

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

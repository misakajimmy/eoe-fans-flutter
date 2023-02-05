import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class PictureDetail extends StatefulWidget {
  const PictureDetail({
    Key? key,
    required this.index,
    required this.images,
  }) : super(key: key);

  final int index;
  final List<String> images;

  @override
  State<PictureDetail> createState() => _PictureDetailState();
}

class _PictureDetailState extends State<PictureDetail> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.index;
    print(currentIndex);
    super.initState();
  }

  _save(String url) async {
    try {
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
      );
      Fluttertoast.showToast(
          msg: "存图成功👌",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "存图失败😒",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black,
                child: ExtendedImageGesturePageView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    var item = widget.images[index];
                    var itemImage = CachedNetworkImageProvider(item);
                    Widget image = ExtendedImage(
                      image: itemImage,
                      fit: BoxFit.contain,
                      mode: ExtendedImageMode.gesture,
                      initGestureConfigHandler: (ExtendedImageState state) {
                        return GestureConfig(
                          inPageView: true,
                          initialScale: 1.0,
                          //you can cache gesture state even though page view page change.
                          //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                          cacheGesture: false,
                        );
                      },
                    );
                    image = Container(
                      child: image,
                      padding: EdgeInsets.all(5.0),
                    );
                    if (index == currentIndex) {
                      return Hero(
                        tag: item + index.toString(),
                        child: image,
                      );
                    } else {
                      return image;
                    }
                  },
                  itemCount: widget.images.length,
                  onPageChanged: (int index) {
                    currentIndex = index;
                  },
                  controller: ExtendedPageController(
                    initialPage: widget.index,
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Positioned(
              left: 4,
              child: SafeArea(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 4,
              child: SafeArea(
                child: IconButton(
                  onPressed: () {
                    _save(widget.images[currentIndex]);
                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

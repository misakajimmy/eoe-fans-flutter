import 'dart:math';

import 'package:eoe_fans/common/Api.dart';
import 'package:eoe_fans/models/index.dart';
import 'package:eoe_fans/models/member.dart';
import 'package:eoe_fans/models/picturesRequest.dart';
import 'package:eoe_fans/routes/picture/pictureMemberFilter.dart';
import 'package:eoe_fans/routes/picture/pictureSwiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PictureList extends StatefulWidget {
  const PictureList({Key? key, required this.pageType}) : super(key: key);

  final PicturePageType pageType;

  @override
  State<PictureList> createState() => _PictureListState();
}

class _PictureListState extends State<PictureList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int _page = 0;
  bool _loading = false;
  MemberEnum? _memberFilter;
  List<Dynamic> dynamicList = [];
  List<Widget> listWidgets = [];

  @override
  void initState() {
    _getPictures();
    _initListWidgets();
    super.initState();
  }

  _initListWidgets() {
    listWidgets = [
      StaggeredGridTile.count(
        crossAxisCellCount: 4,
        mainAxisCellCount: 1,
        child: Center(
          child: Container(
            child: PictureMemberFilter(
              filter: _memberFilter,
              updateFilterMember: (MemberEnum? value) {
                _memberFilter = value;
                _reloadPictures();
              },
            ),
          ),
        ),
      )
    ];
  }

  _getPictures() async {
    setState(() {
      _loading = true;
      _page++;
    });
    PicturesTopic topic = PicturesTopic.all;
    switch (_memberFilter) {
      case MemberEnum.zao:
        topic = PicturesTopic.zao;
        break;
      case MemberEnum.mi:
        topic = PicturesTopic.mi;
        break;
      case MemberEnum.wan:
        topic = PicturesTopic.wan;
        break;
      case MemberEnum.mo:
        topic = PicturesTopic.mo;
        break;
      case MemberEnum.un:
        topic = PicturesTopic.un;
        break;
      default:
        topic = PicturesTopic.all;
    }
    PicturesRequest param = PicturesRequest()
      ..page = _page
      ..topic_id = topic;
    Pictures pictures = widget.pageType == PicturePageType.recommend
        ? await Api(context).picturesRecommend(param)
        : await Api(context).picturesLatest(param);
    if (pictures.result.length != 0) {
      setState(() {
        dynamicList = [...dynamicList, ...pictures.result];
        listWidgets = [
          ...listWidgets,
          ...pictures.result.map(
            (e) {
              return StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 3,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: PictureSwiper(
                    dynamicId: e.dynamic_id.toString(),
                    images: e.pictures.map((e) => e.img_src).toList(),
                  ),
                ),
              );
            },
          ).toList()
        ];
        _loading = false;
      });
    } else {
      await Future.delayed(Duration(seconds: 5), () {
        _getPictures();
      });
    }
  }

  _reloadPictures({int? page}) async {
    dynamicList = [];
    setState(() {
      _initListWidgets();
    });
    _page = page ?? 0;
    await _getPictures();
  }

  void _onRefresh() async {
    // monitor network fetch
    await _reloadPictures();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await _getPictures();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("????????????");
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("??????????????????????????????");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("??????,????????????!");
        } else {
          body = Text("?????????????????????!");
        }
        return Container(
          child: Center(child: body),
        );
      }),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: listWidgets,
      ),
      // child: ListView.builder(
      //   itemBuilder: (c, i) => Container(
      //     child: i == 0
      //         ? SizedBox(
      //             width: double.infinity,
      //             height: 84,
      //             child: PictureMemberFilter(
      //               filter: _memberFilter,
      //               updateFilterMember: (MemberEnum? value) {
      //                 _memberFilter = value;
      //                 _reloadPictures();
      //               },
      //             ),
      //           )
      //         : SizedBox(
      //             width: double.infinity,
      //             height: 480,
      //             child: Card(
      //               clipBehavior: Clip.antiAliasWithSaveLayer,
      //               child: PictureSwiper(
      //                 dynamicId: dynamicList[i].dynamic_id.toString(),
      //                 images: dynamicList[i]
      //                     .pictures
      //                     .map((e) => e.img_src)
      //                     .toList(),
      //               ),
      //             ),
      //           ),
      //
      //     // child: Center(
      //     //   child: Image(
      //     //     image: CachedNetworkImageProvider(dynamicList[i].pictures[0].img_src),
      //     //     fit: BoxFit.fitWidth,
      //     //     width: double.infinity,
      //     //   ),
      //     // ),
      //   ),
      //   itemCount: dynamicList.length,
      // ),
    );
  }
}

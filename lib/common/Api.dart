import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eoe_fans/models/videos.dart';
import 'package:eoe_fans/models/iResponse.dart';
import 'package:eoe_fans/models/videosRequest.dart';
import 'package:flutter/cupertino.dart';

import 'Global.dart';

class Api {
  Api([this.context]);

  BuildContext? context;

  static String key = '7e013c02952c41078c18ab26f639f02e';

  //  Options _options;
  static Dio dio =
      Dio(BaseOptions(baseUrl: 'https://api.eoe.best/eoefans-api/v1', headers: {
    'ocp-apim-subscription-key': key,
    'Content-Type': 'application/json',
  }));

  static void init() {
    //添加缓存插件
    dio.interceptors.add(Global.netCache);
    //设置用户token(null,为未登录)
    // dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
  }

  Future<Videos> videos(VideosRequest params) async {
    var paramsData = ({...params.toJson(), 'subscription-key': key});
    paramsData.removeWhere((key, value) => value == null);
    print(paramsData);
    var r = await dio.get('/video-interface/advanced-search',
        queryParameters: paramsData);
    var tmpVideos = Videos()
      ..page = 0
      ..numResults = 0
      ..result = [];
    if (r.statusCode == 200) {
      var videoRes =
          IResponse<Videos>.fromJson(r.data, (json) => Videos.fromJson(json));
      print(videoRes.data?.page);
      print(videoRes.data?.numResults);
      if (videoRes.data != null) {
        tmpVideos = videoRes.data!;
      }
    }
    return tmpVideos;
  }
}

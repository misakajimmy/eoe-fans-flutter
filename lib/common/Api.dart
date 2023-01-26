import 'package:dio/dio.dart';
import 'package:eoe_fans/models/pictures.dart';
import 'package:eoe_fans/models/picturesRequest.dart';
import 'package:eoe_fans/models/version.dart';
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
    var tmpVideos = Videos()
      ..page = 0
      ..numResults = 0
      ..result = [];

    try {
      var paramsData = ({...params.toJson(), 'subscription-key': key});
      paramsData.removeWhere((key, value) => value == null);
      var r = await dio.get('/video-interface/advanced-search',
          queryParameters: paramsData);

      if (r.statusCode == 200) {
        var videoRes =
            IResponse<Videos>.fromJson(r.data, (json) => Videos.fromJson(json));
        if (videoRes.data != null) {
          tmpVideos = videoRes.data!;
        }
      }
    } catch (e) {
      print(e);
    }

    return tmpVideos;
  }

  Future<Pictures> picturesRecommend(PicturesRequest params) async {
    var tmpPictures = Pictures()
        ..page=0
        ..total=0
        ..result=[];
    try {
      var paramsData = ({...params.toJson(), 'subscription-key': key});
      paramsData.removeWhere((key, value) => value == null);
      var r = await dio.get('/pic/recommend',
          queryParameters: paramsData);

      if (r.statusCode == 200) {
        var picturesRes =
        IResponse<Pictures>.fromJson(r.data, (json) => Pictures.fromJson(json));
        if (picturesRes.data != null) {
          tmpPictures = picturesRes.data!;
        }
      }
    } catch(e) {
      print(e);
    }
    return tmpPictures;
  }

  Future<Pictures> picturesLatest(PicturesRequest params) async {
    var tmpPictures = Pictures()
      ..page=0
      ..total=0
      ..result=[];
    try {
      var paramsData = ({...params.toJson(), 'subscription-key': key});
      paramsData.removeWhere((key, value) => value == null);
      var r = await dio.get('/pic/latest',
          queryParameters: paramsData);

      if (r.statusCode == 200) {
        var picturesRes =
        IResponse<Pictures>.fromJson(r.data, (json) => Pictures.fromJson(json));
        if (picturesRes.data != null) {
          tmpPictures = picturesRes.data!;
        }
      }
    } catch(e) {
      print(e);
    }
    return tmpPictures;
  }
  Future<Version> version() async {
    var paramsData = ({'subscription-key': key});
    paramsData.removeWhere((key, value) => value == null);
    var r = await dio.get('/tools/version', queryParameters: paramsData);
    var tmpVersion = Version()
      ..version = ''
      ..version_message = ''
      ..download_url = {}
      ..updated_at = '';
    if (r.statusCode == 200) {
      var versionRes =
          IResponse<Version>.fromJson(r.data, (json) => Version.fromJson(json));
      if (versionRes.data != null) {
        tmpVersion = versionRes.data!;
      }
    }
    return tmpVersion;
  }
}

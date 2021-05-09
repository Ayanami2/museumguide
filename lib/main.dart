import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:museumguide/page/comment_page.dart';
import 'package:museumguide/page/main_login.dart';
import 'package:museumguide/page/home_page.dart';
import 'package:museumguide/page/map_page.dart';
import 'package:museumguide/page/mine/aboutus_page.dart';
import 'package:museumguide/page/mine/mine_page.dart';
import 'package:museumguide/page/mine/setting_page.dart';
import 'package:museumguide/page/my_videos.dart';
import 'package:museumguide/page/video_select.dart';

void main() async {
  // print(UserService.isUserExist(searchedIDNumber: "532301154091545872").toString());

  if (Platform.isIOS) {
    BMFMapSDK.setApiKeyAndCoordType(
        '请输入百度开放平台申请的iOS端API KEY', BMF_COORD_TYPE.BD09LL);
  } else if (Platform.isAndroid) {
// Android 目前不支持接口设置Apikey,
// 请在主工程的Manifest文件里设置，详细配置方法请参考[https://lbsyun.baidu.com/ 官网][https://lbsyun.baidu.com/)demo
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      allowFontScaling: false,
      builder: () => MaterialApp(title: 'Flutter Demo', routes: {
        '/': (context) => (MainLoginPage()),
        'home_page': (context) => (HomePage()),
        'comment_page': (context) => (CommentPage()),
        'map_page': (context) => (MapPage()),
        'mine_page': (context) => (MinePage()),
        'setting_page': (context) => (SettingPage()),
        'login_page': (context) => (LoginPage()),
        'register_page': (context) => (RegisterPage()),
        'video_select_page': (context) => (VideoSelectPage()),
        'my_videos': (context) => (MyVideo()),
        'about_us': (context) => (AboutusPage()),
      }),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:museumguide/page/comment_page.dart';
import 'package:museumguide/page/home_page.dart';
import 'package:museumguide/page/map_page.dart';
import 'package:museumguide/page/mine/mine_page.dart';
import 'package:museumguide/page/mine/settings.dart';
import 'package:museumguide/service/index.dart';
import 'package:museumguide/models/index.dart';
import 'package:http/http.dart' as http;
import 'package:museumguide/config/index.dart';
import 'package:museumguide/page/video_select.dart';

void main() async {
  // User u = await UserService.getUserByAccountNumber(accountNumber: 100010);
  // print(u.nickName);
  // User u1 = new User()
  //   ..name = "lcynb"
  //   ..password = "password"
  //   ..accountNumber = 100165675
  //   ..IDNumber = "360102255591987569";
  // UserService.insertUser(insertedUser: u1);
  // UserService.updatePassword(accountNumber: 100165675,password: "lcynb");

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
        '/': (context) => (HomePage()),
        'comment_page': (context) => (CommentPage()),
        'map_page': (context) => (MapPage()),
        'mine_page': (context) => (MinePage()),
        'settings_page': (context) => (SettingsPage()),
        'video_select_page': (context) => (VideoSelectPage()),
      }),
    );
  }
}

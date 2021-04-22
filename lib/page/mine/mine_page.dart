import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:museumguide/config/index.dart';
import 'package:museumguide/widgets/index.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final String nickname = '肖开源'; //昵称
  final String portrait =
      'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2846913929,4125395355&fm=26&gp=0.jpg'; //我的头像

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(50.0),
                ),
                child: Portrait(
                  radius: 50,
                  imageProvider: NetworkImage(portrait),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20.0),
              ),
              Text(
                nickname,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20.0),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(60.0),
                ),
              ),
              Divider(
                height: ScreenUtil().setHeight(1.0),
                color: Color(0xffd3d3d3),
              ),
              //收藏
              IconTextArrowWidget(
                  KIcon.COLLECTION, KString.COLLECTION, Colors.red, () {
                Navigator.pushNamed(context, 'collection');
              }),
              Divider(
                height: ScreenUtil().setHeight(1.0),
                color: Color(0xffd3d3d3),
              ),
              IconTextArrowWidget(
                  KIcon.SETTINGS, KString.SETTINGS, Colors.amber, () {
                Navigator.pushNamed(context, 'settings_page');
              }),
              Divider(
                height: ScreenUtil().setHeight(1.0),
                color: Color(0xffd3d3d3),
              ),
              IconTextArrowWidget(
                  KIcon.ABOUT_US, KString.ABOUT_US, Colors.teal, () {
                Navigator.pushNamed(context, 'about_us');
              }),
              Divider(
                height: ScreenUtil().setHeight(1.0),
                color: Color(0xffd3d3d3),
              ),
            ],
          )
        ],
      ),
    );
  }
}

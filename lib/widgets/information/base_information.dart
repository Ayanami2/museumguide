import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/index.dart';
import 'video_play.dart';

class BaseInformation extends StatelessWidget {
  final MuseumBasicInformation museumBaseInformation;

  BaseInformation({Key key, this.museumBaseInformation}) : super(key: key);

  Widget getChartItem(String title, String context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: ScreenUtil().setSp(20.0)),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(8.0),
        ),
        Expanded(
          child: Text(
            context ?? '',
            style: TextStyle(fontSize: ScreenUtil().setSp(18.0)),
          ),
        )
      ],
    );
  }

  Widget getInformation() {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '博物馆信息',
            style: TextStyle(fontSize: ScreenUtil().setSp(25.0)),
          ),
          Divider(
            color: Colors.black,
            height: 1.0,
          ),
          getChartItem(
            '    地址    ',
            museumBaseInformation.address,
          ),
          Divider(height: 1.0),
          getChartItem(
            '开放时间',
            museumBaseInformation.openingTime,
          ),
          Divider(height: 1.0),
          getChartItem(
            '    电话    ',
            museumBaseInformation.consultationTelephone,
          ),
          Divider(height: 1.0),
          getChartItem(
            '    介绍    ',
            museumBaseInformation.introduction,
          ),
        ],
      ),
    );
  }

  Widget getVideo() {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10.0)),
      ),
      child: (museumBaseInformation.publicityVideoLink == null)
          ? Text(
              '暂无简介视频',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: ScreenUtil().setSp(20.0)),
            )
          : VideoPlay(url: museumBaseInformation.publicityVideoLink),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView(
        children: [
          getInformation(),
          getVideo(),
        ],
      ),
    );
  }
}

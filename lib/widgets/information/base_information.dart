import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/index.dart';

class BaseInformation extends StatelessWidget {
  final MuseumBasicInformation museumBaseInformation;

  BaseInformation({Key key, this.museumBaseInformation}) : super(key: key);

  Widget getInformation() {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.brown[200],
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
          MuseumBaseInformationItem(
            title: '    地址    ',
            context: museumBaseInformation.address,
          ),
          Divider(
            height: 1.0,
          ),
          MuseumBaseInformationItem(
            title: '开放时间',
            context: museumBaseInformation.openingTime,
          ),
          Divider(
            height: 1.0,
          ),
          MuseumBaseInformationItem(
            title: '    电话    ',
            context: museumBaseInformation.consultationTelephone,
          ),
          Divider(
            height: 1.0,
          ),
          MuseumBaseInformationItem(
            title: '    介绍    ',
            context: museumBaseInformation.introduction,
          )
        ],
      ),
    );
  }

  Widget getVideo() {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10.0)),
      ),
      child: Text(museumBaseInformation.publicityVideoLink),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          getInformation(),
          getVideo(),
        ],
      ),
    );
  }
}

class MuseumBaseInformationItem extends StatelessWidget {
  final String title, context;

  MuseumBaseInformationItem({Key key, this.title, this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          this.title,
          style: TextStyle(fontSize: ScreenUtil().setSp(15.0)),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(8.0),
        ),
        Expanded(
          child: Text(
            this.context ?? '',
            style: TextStyle(fontSize: ScreenUtil().setSp(10.0)),
          ),
        )
      ],
    );
  }
}
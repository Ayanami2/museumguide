///author:swg
///updateDate:2021/4/23
///updateBy:swg
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/information/museum_item.dart';

class MuseumListPage extends StatefulWidget {
  @override
  _MuseumListPageState createState() => _MuseumListPageState();
}

class _MuseumListPageState extends State<MuseumListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('博物馆总览'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, i) => MuseumItem(
                  index: i,
                ),
            separatorBuilder: (context, i) => Divider(
                  height: ScreenUtil().setHeight(1.0),
                ),
            itemCount: 10),
      ),
    );
  }
}

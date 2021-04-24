///author:swg
///updateDate:2021/4/23
///updateBy:swg
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/information_util.dart';

class MuseumItem extends StatelessWidget {
  final num index;

  MuseumItem({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10.0)),
      ),
      child: GestureDetector(
        onTap: () => null,
        child: Row(
          children: [
            Icon(
              Icons.museum,
              size: ScreenUtil().setHeight(20.0),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(10.0),
            ),
            Text(
              Information.museumList[index],
              style: TextStyle(fontSize: ScreenUtil().setSp(18.0)),
            )
          ],
        ),
      ),
    );
  }
}

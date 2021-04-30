import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/index.dart';
import '../../config/information_util.dart';
import '../../page/information/museum_information.dart';

class MuseumItem extends StatelessWidget {
  final MuseumBasicInformation information;
  final num index;

  MuseumItem({Key key, this.information, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10.0)),
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MuseumInformation(
                      museumInformation: information,
                    ))),
        child: Row(
          children: [
            Icon(
              Icons.museum,
              color: Information.colorList[index % 5],
              size: ScreenUtil().setHeight(20.0),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(10.0),
            ),
            Container(
              height: ScreenUtil().setHeight(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    information.museumName,
                    style: TextStyle(fontSize: ScreenUtil().setSp(18.0)),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8.0),
                  ),
                  Text(
                    information.address,
                    style: TextStyle(fontSize: ScreenUtil().setSp(8.0)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

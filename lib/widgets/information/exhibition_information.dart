import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/index.dart';

class ExhibitionInformation extends StatelessWidget {
  final List<Exhibition> exhibitionList;

  const ExhibitionInformation({Key key, this.exhibitionList}) : super(key: key);

  Widget getItem(int i) {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10.0)),
      ),
      child: Row(
        children: [
          Image.network(
            exhibitionList[i].exhibitionImageLink,
            width: ScreenUtil().setWidth(100.0),
            height: ScreenUtil().setHeight(100.0),
          ),
          SizedBox(width: ScreenUtil().setWidth(10.0)),
          Expanded(
            child: SizedBox(
              height: ScreenUtil().setHeight(100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        exhibitionList[i].exhibitionName,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: ScreenUtil().setSp(18.0)),
                      ),
                    ),
                  ),
                  Text(
                    exhibitionList[i].exhibitionTime,
                    style: TextStyle(fontSize: ScreenUtil().setSp(12.0)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getDialogWidget(int i) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ScreenUtil().setWidth(10.0)),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ScreenUtil().setWidth(10.0)),
        ),
        child: ListView(
          children: [
            if (exhibitionList[i].exhibitionImageLink == null)
              Center(child: Text('暂无图片'))
            else
              Image.network(
                exhibitionList[i].exhibitionImageLink,
                fit: BoxFit.cover,
              ),
            Container(
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(ScreenUtil().setWidth(10.0)),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    exhibitionList[i].exhibitionName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(25.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(height: 1.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '展览时间',
                        style: TextStyle(fontSize: ScreenUtil().setSp(20.0)),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10.0)),
                      Expanded(
                        child: Text(
                          exhibitionList[i].exhibitionTime,
                          style: TextStyle(fontSize: ScreenUtil().setSp(16.0)),
                        ),
                      )
                    ],
                  ),
                  Divider(height: 1.0),
                  Text(
                    '展览简介',
                    style: TextStyle(fontSize: ScreenUtil().setSp(20.0)),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5.0)),
                  Text(
                    exhibitionList[i].exhibitionIntroduction ?? '暂无展览介绍',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: ScreenUtil().setSp(16.0)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
          itemBuilder: (context, i) {
            return Container(
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(10.0)),
                  ),
                  builder: (context) => getDialogWidget(i),
                ),
                child: getItem(i),
              ),
            );
          },
          itemCount: exhibitionList.length),
    );
  }
}

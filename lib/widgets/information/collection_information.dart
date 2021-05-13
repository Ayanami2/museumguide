import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/index.dart';

class CollectionInformation extends StatelessWidget {
  final List<Collection> collectionList;

  const CollectionInformation({Key key, this.collectionList}) : super(key: key);

  Widget getItem(int i) {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            collectionList[i].collectionImageLink,
            width: ScreenUtil().setWidth(150.0),
            height: ScreenUtil().setHeight(150.0),
          ),
          Expanded(
            child: Center(
              child: Text(
                collectionList[i].collectionName,
                style: TextStyle(fontSize: ScreenUtil().setSp(15.0)),
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
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10.0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ScreenUtil().setWidth(10.0)),
        ),
        child: ListView(
          children: [
            if (collectionList[i].collectionImageLink == null)
              Center(child: Text('暂无图片'))
            else
              Image.network(
                collectionList[i].collectionImageLink,
                fit: BoxFit.cover,
              ),
            Container(
              margin: EdgeInsets.all(2.0),
              padding: EdgeInsets.all(3.0),
              color: Colors.grey[300],
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    collectionList[i].collectionName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(25.0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(height: 1.0),
                  Text(
                    '藏品简介',
                    style: TextStyle(fontSize: ScreenUtil().setSp(20.0)),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5.0)),
                  Text(
                    collectionList[i].collectionIntroduction ?? '暂无藏品简介',
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
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
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
        itemCount: collectionList.length,
      ),
    );
  }
}

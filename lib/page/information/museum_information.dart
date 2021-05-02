import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../service/index.dart';
import '../../widgets/information/museum_base_information.dart';
import '../../models/index.dart';

class MuseumInformation extends StatefulWidget {
  final num museumID;

  MuseumInformation({Key key, this.museumID}) : super(key: key);

  @override
  _MuseumInformationState createState() => _MuseumInformationState();
}

class _MuseumInformationState extends State<MuseumInformation> {
  MuseumBasicInformation museumBasicInformation;
  List<Exhibition> exhibitionList;
  num widgetIndex;

  void getData() async {
    MuseumBasicInformationService.getMuseumByMuseumID(museumID: widget.museumID)
        .then((value) => setState(() => museumBasicInformation = value));
    ExhibitionService.getExhibitionListByMuseumID(museumID: widget.museumID)
        .then((value) => setState(() => exhibitionList = value));
  }

  @override
  void initState() {
    super.initState();
    getData();
    widgetIndex = 0;
  }

  Widget getButton(String data, num index) {
    return GestureDetector(
      onTap: () => setState(() => widgetIndex = index),
      child: Text(
        data,
        style: TextStyle(fontSize: ScreenUtil().setSp(18.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('museum'),
        centerTitle: true,
      ),
      body: (museumBasicInformation == null || exhibitionList == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(2.0),
                    padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10.0)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          museumBasicInformation.museumName,
                          style: TextStyle(fontSize: ScreenUtil().setSp(40.0)),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getButton('基本信息', 0),
                      getButton('展览信息', 1),
                      getButton('藏品信息', 2)
                    ],
                  ),
                  widgetIndex == 0
                      ? MuseumBaseInformation(
                          museumBaseInformation: museumBasicInformation,
                        )
                      : widgetIndex == 1
                          ? Center(
                              child: Text('exhibition'),
                            )
                          : Center(
                              child: Text('collection'),
                            )
                ],
              ),
            ),
    );
  }
}

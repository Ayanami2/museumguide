import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../service/index.dart';
import '../../widgets/information/base_information.dart';
import '../../models/index.dart';

class MuseumInformation extends StatefulWidget {
  final num museumID;

  MuseumInformation({Key key, this.museumID}) : super(key: key);

  @override
  _MuseumInformationState createState() => _MuseumInformationState();
}

class _MuseumInformationState extends State<MuseumInformation>
    with SingleTickerProviderStateMixin {
  MuseumBasicInformation museumBasicInformation;
  List<Exhibition> exhibitionList;
  num widgetIndex;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    MuseumBasicInformationService.getMuseumByMuseumID(museumID: widget.museumID)
        .then((value) => setState(() => museumBasicInformation = value));
    ExhibitionService.getExhibitionListByMuseumID(museumID: widget.museumID)
        .then((value) => setState(() => exhibitionList = value));
    widgetIndex = 0;
    this._tabController = TabController(length: 3, vsync: this);
  }

  /*Widget getButton(String data, num index) {
    return GestureDetector(
      onTap: () => setState(() => widgetIndex = index),
      child: Text(
        data,
        style: TextStyle(fontSize: ScreenUtil().setSp(18.0)),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return (museumBasicInformation == null || exhibitionList == null)
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                museumBasicInformation.museumName,
                style: TextStyle(fontSize: ScreenUtil().setSp(30.0)),
              ),
              centerTitle: true,
            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    color: Colors.teal,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: "基本信息"),
                        Tab(text: "展览信息"),
                        Tab(text: "藏品信息"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        BaseInformation(
                          museumBaseInformation: museumBasicInformation,
                        ),
                        Center(
                          child: Text('exhibition'),
                        ),
                        Center(
                          child: Text('collection'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

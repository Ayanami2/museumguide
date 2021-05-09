import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/index.dart';
import '../../service/index.dart';
import '../../widgets/information/base_information.dart';
import '../../widgets/information/exhibition_information.dart';
import '../../widgets/information/collection_information.dart';

class MuseumInformation extends StatefulWidget {
  final num museumID;

  MuseumInformation({Key key, this.museumID}) : super(key: key);

  @override
  _MuseumInformationState createState() => _MuseumInformationState();
}

class _MuseumInformationState extends State<MuseumInformation> {
  MuseumBasicInformation museumBasicInformation;
  List<Exhibition> exhibitionList;
  List<Collection> collectionList;

  @override
  void initState() {
    super.initState();
    MuseumBasicInformationService.getMuseumByMuseumID(museumID: widget.museumID)
        .then((value) => setState(() => museumBasicInformation = value));
    ExhibitionService.getExhibitionListByMuseumID(museumID: widget.museumID)
        .then((value) => setState(() => exhibitionList = value));
    CollectionService.getCollectionListByMuseumID(museumID: widget.museumID)
        .then((value) => setState(() => collectionList = value));
  }

  @override
  Widget build(BuildContext context) {
    if (museumBasicInformation == null ||
        exhibitionList == null ||
        collectionList == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            museumBasicInformation.museumName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: ScreenUtil().setSp(30.0)),
          ),
        ),
        body: DefaultTabController(
          length: 3,
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.teal,
                  child: TabBar(
                    indicatorColor: Colors.red,
                    tabs: [
                      Tab(text: "基本信息"),
                      Tab(text: "展览列表"),
                      Tab(text: "藏品列表"),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      BaseInformation(
                        museumBaseInformation: museumBasicInformation,
                      ),
                      ExhibitionInformation(
                        exhibitionList: exhibitionList,
                      ),
                      CollectionInformation(
                        collectionList: collectionList,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

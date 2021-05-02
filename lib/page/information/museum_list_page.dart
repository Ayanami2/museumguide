import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../service/index.dart';
import '../../models/index.dart';
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
        child: FutureBuilder(
          future: MuseumBasicInformationService.getMuseumList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MuseumBasicInformation> list = snapshot.data;
              return ListView.separated(
                  itemBuilder: (context, i) => MuseumItem(
                        information: list[i],
                        index: i,
                      ),
                  separatorBuilder: (context, i) => Divider(
                        height: ScreenUtil().setHeight(1.0),
                      ),
                  itemCount: list.length);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

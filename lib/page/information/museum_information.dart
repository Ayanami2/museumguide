import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/information/museum_base_information.dart';
import '../../models/index.dart';

class MuseumInformation extends StatefulWidget {
  final MuseumBasicInformation museumInformation;

  MuseumInformation({Key key, this.museumInformation}) : super(key: key);

  @override
  _MuseumInformationState createState() => _MuseumInformationState();
}

class _MuseumInformationState extends State<MuseumInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('museum'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
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
                      widget.museumInformation.museumName,
                      style: TextStyle(fontSize: ScreenUtil().setSp(40.0)),
                    )
                  ],
                ),
              ),
              MuseumBaseInformation(
                museumBaseInformation: widget.museumInformation,
              ),
              widget.museumInformation.publicityVideoLink != null
                  ? Text(
                      '显示播放组件\n' + widget.museumInformation.publicityVideoLink)
                  : SizedBox(
                      height: 0.0,
                    )
            ],
          ),
        ),
      ),
    );
  }
}

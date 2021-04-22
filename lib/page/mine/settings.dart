import 'package:flutter/material.dart';
import 'package:museumguide/widgets/index.dart';
import 'mine_page.dart';
import 'dart:async';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void onBMFMapCreated(BMFMapController controller) {
    BMFMarker marker = BMFMarker(
        position: BMFCoordinate(39.928617, 116.40329),
        title: 'flutterMaker',
        subtitle: 'test',
        identifier: 'flutter_marker',
        icon: 'resource/animation_red.png');
    // bool result;
    controller?.addMarker(marker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BMFMapWidget(
          onBMFMapCreated: (mapController) {
            onBMFMapCreated(mapController);
          },
          mapOptions: BMFMapOptions(
            center: BMFCoordinate(39.917215, 116.380341),
            zoomLevel: 12,
          ),
        ),
      ),
    );
  }
}

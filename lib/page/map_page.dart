// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumguide/models/index.dart';
import 'package:museumguide/widgets/index.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:museumguide/service/index.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends BMFBaseMapState<MapPage> {
  /// 定位模式状态
  bool _showUserLocation = true;

  String _btnText = "关闭";

  /// 我的位置
  BMFUserLocation _userLocation;

  /// 定位模式
  BMFUserTrackingMode _userTrackingMode = BMFUserTrackingMode.Follow;

  /// 定位点样式
  BMFUserLocationDisplayParam _displayParam;

  ///markerID转museumID
  Map<String, String> maker2museum = {};

  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    /// 地图加载回调

    if (_showUserLocation) {
      myMapController?.showUserLocation(true);
      updateUserLocation();
      myMapController?.setUserTrackingMode(_userTrackingMode);
      // updatUserLocationDisplayParam();
    }
    BMFCoordinate bmfCoordinate = BMFCoordinate(40.258911, 116.15437);
    addStartMarker(bmfCoordinate);
    bmfCoordinate = BMFCoordinate(39.924091, 116.4034147);
    // addMuseum(bmfCoordinate);
    addMuseums();

    myMapController?.setMapClickedMarkerCallback(callback: (BMFMarker marker) {
      print(marker.position.latitude);
      print(marker.position.longitude);
      print(marker.Id);
      print(marker.identifier);
      print(marker.title);
      showDialog(
        context: context,
        builder: (ctx) {
          return museumInfoWindow(int.parse(maker2museum[marker.Id]));
        },
      );
    });
  }

  StreamBuilder baiduMap() {
    return StreamBuilder<Map<String, Object>>(
        stream: baiduGps(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("纬度");
            print(snapshot.data["latitude"]);
            print("经度");
            print(snapshot.data["longitude"]);
            return Container(
              height: screenSize.height,
              width: screenSize.width,
              child: BMFMapWidget(
                onBMFMapCreated: (mapController) {
                  onBMFMapCreated(mapController);
                },
                mapOptions: BMFMapOptions(
                  center: BMFCoordinate(
                      snapshot.data["latitude"], snapshot.data["longitude"]),
                  zoomLevel: 18,
                  maxZoomLevel: 18,
                  minZoomLevel: 8,
                  mapPadding:
                  BMFEdgeInsets(top: 0, left: 50, right: 50, bottom: 0),
                ),
              ),
            );
          } else
            return Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("博物馆导览"),
        ),
        body: baiduMap(),
      ),
    );
  }

  // /// 设置地图参数
  // @override
  // BMFMapOptions initMapOptions() {
  //   BMFMapOptions mapOptions = BMFMapOptions(
  //     center: BMFCoordinate(39.965, 116.404),
  //     zoomLevel: 18,
  //     maxZoomLevel: 18,
  //     minZoomLevel: 15,
  //     mapPadding: BMFEdgeInsets(top: 0, left: 50, right: 50, bottom: 0),
  //   );
  //   return mapOptions;
  // }

  void setUserLocationMode(BMFUserTrackingMode userTrackingMode) {
    setState(() {
      this._userTrackingMode = userTrackingMode;
    });

    if (!_showUserLocation) {
      return;
    }

    myMapController?.setUserTrackingMode(userTrackingMode,
        enableDirection: false);

    if (BMFUserTrackingMode.Follow == userTrackingMode ||
        BMFUserTrackingMode.Heading == userTrackingMode) {
      myMapController?.setNewMapStatus(
          mapStatus: BMFMapStatus(fOverlooking: 0));
    }
  }

  /// 更新位置
  void updateUserLocation() {
    Stream<Map<String, Object>> stream = baiduGps();
    stream.listen((event) {
      BMFCoordinate coordinate =
          BMFCoordinate(event["latitude"], event["longitude"]);
      BMFLocation location = BMFLocation(
          coordinate: coordinate,
          altitude: 0,
          horizontalAccuracy: 5,
          verticalAccuracy: -1.0,
          speed: -1.0,
          course: -1.0);
      BMFUserLocation userLocation = BMFUserLocation(
        location: location,
      );
      _userLocation = userLocation;
      myMapController?.updateLocationData(_userLocation);
    });
  }

  // void updatUserLocationDisplayParam() {
  //   BMFUserLocationDisplayParam displayParam = BMFUserLocationDisplayParam(
  //       locationViewOffsetX: 0,
  //       locationViewOffsetY: 0,
  //       accuracyCircleFillColor: Colors.red,
  //       accuracyCircleStrokeColor: Colors.blue,
  //       isAccuracyCircleShow: true,
  //       locationViewImage: 'resource/animation_red.png',
  //       locationViewHierarchy:
  //       BMFLocationViewHierarchy.LOCATION_VIEW_HIERARCHY_BOTTOM);
  //
  //   _displayParam = displayParam;
  //   myMapController?.updateLocationViewWithParam(_displayParam);
  // }

  Stream<Map<String, Object>> baiduGps() async* {
    //创建一个定位对象，后续操作时使用
    LocationFlutterPlugin _locationPlugin = new LocationFlutterPlugin();

// 设置安卓定位参数(按官方文档复制过来就可以了)
    BaiduLocationAndroidOption androidOption = new BaiduLocationAndroidOption();
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddres(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(true); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(LocationMode.Hight_Accuracy); // 设置定位模式
    androidOption.setScanspan(0); // 设置发起定位请求时间间隔
    Map androidMap = androidOption.getMap();

//ios定位参数设置(用不上也要设置,按默认就可以了)
    BaiduLocationIOSOption iosOption = new BaiduLocationIOSOption();
    Map iosdMap = iosOption.getMap();

    _locationPlugin.requestPermission(); //请求定位权限
    _locationPlugin.prepareLoc(androidMap, iosdMap); //ios和安卓定位设置

    _locationPlugin.startLocation(); //开始定位

    //  获取定位结果
    yield* _locationPlugin.onResultCallback();
    // gps.listen((event) {
    //   //event就是获取到的结果,是订阅模式的，需要一直监听
    //   print(event.values);
    //   print("纬度");
    //   print(event["latitude"]);
    //   print("经度");
    //   print(event["longitude"]);
    //   print(event["address"]); //打印地址
    //   print(event["province"]); //省份
    // });
    // // _locationPlugin.stopLocation();//停止定位（这里暂时不用）
  }

  void addStartMarker(BMFCoordinate bmfCoordinate) {
    BMFMarker marker = BMFMarker(
        position: bmfCoordinate,
        title: 'startLocation',
        subtitle: 'test',
        identifier: 'startLocation',
        icon: 'resource/icon_ugc_start.png');
    // bool result;
    myMapController?.addMarker(marker);
  }

  void addMuseum(BMFCoordinate bmfCoordinate) {
    BMFMarker marker = BMFMarker(
        position: bmfCoordinate,
        title: 'museumLocation',
        subtitle: 'test',
        identifier: 'museumLocation',
        icon: 'resource/icons8-museum-64.png');
    // bool result;
    myMapController?.addMarker(marker);
  }

  void addMuseums() async {
    List<MuseumBasicInformation> l =
    await MuseumBasicInformationService.getMuseumList();
    for (MuseumBasicInformation obj in l) {
      BMFMarker marker = BMFMarker(
          position: BMFCoordinate(
              double.parse(obj.latitude), double.parse(obj.longitude)),
          title: obj.museumID.toString(),
          subtitle: 'test',
          identifier: obj.museumID.toString(),
          icon: 'resource/icons8-museum-64.png');
      // bool result;
      maker2museum.addAll({marker.Id: obj.museumID.toString()});
      myMapController?.addMarker(marker);
    }
  }
}

Widget museumInfoWindow(int museumID) {
  return FutureBuilder<List<Exhibition>>(
    future: ExhibitionService.getExhibitionListByMuseumID(museumID: museumID),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Portrait(
              radius: 30.0,
              imageProvider: NetworkImage(
                'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2846913929,4125395355&fm=26&gp=0.jpg',
              ),
            ),
            Text(
              '博物馆', //snapshot.data[0].museumName,
              style: TextStyle(
                color: Colors.teal.shade100,
                fontSize: ScreenUtil().setSp(20.0),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20.0),
              width: ScreenUtil().setWidth(150.0),
              child: (Divider(
                color: Colors.teal.shade100,
              )),
            ),
            Text(
              'exhibitionIntroduction',
              //snapshot.data[0].exhibitionIntroduction,
              style: TextStyle(
                color: Colors.teal.shade100,
                fontSize: ScreenUtil().setSp(15.0),
                // fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(50.0),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  color: Colors.lightBlue,
                  onPressed: () {
                    print(1);
                  },
                  child: Text(
                    '进入博物馆',
                  ),
                ),
                FlatButton(
                  color: Colors.lightBlue,
                  onPressed: () {
                    print(2);
                  },
                  child: Text(
                    '进入视频讲解',
                  ),
                ),
              ],
            )
          ],
        ));
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

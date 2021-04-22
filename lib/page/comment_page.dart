import 'package:flutter/material.dart';
//以下为百度地图插件需要引用的库
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';
void baibuGps(){
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
  _locationPlugin.prepareLoc(androidMap,iosdMap); //ios和安卓定位设置

  _locationPlugin.startLocation(); //开始定位

  //  获取定位结果
  var gps=_locationPlugin.onResultCallback();
  gps.listen((event) {
    //event就是获取到的结果,是订阅模式的，需要一直监听
    print(event.values);
    print("纬度");
    print(event["latitude"]);
    print("经度");
    print(event["longitude"]);
    print(event["address"]); //打印地址
    print(event["province"]);  //省份
  });
  // // _locationPlugin.stopLocation();//停止定位（这里暂时不用）
}

class CommentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("百度地图定位"),
      ),
      body:Center(
        child: RaisedButton(
          onPressed: baibuGps, //定位函数在这里调用
          child: Text("定位"),
        ),
      ),
    );
  }
}

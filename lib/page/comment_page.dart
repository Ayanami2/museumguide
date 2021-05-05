import 'package:flutter/material.dart';
//以下为百度地图插件需要引用的库
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';
class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  ListView VideoList() {
    return ListView(
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
     
            title: Text("视频浏览"),
            actions: [
              FlatButton(
                onPressed: (){
                  Navigator.pushNamed(context,'video_select_page');
                },
                child: Text("发布视频"),
              ),
            ],
          ),
          body:Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

//以下为百度地图插件需要引用的库
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_android_option.dart';
import 'package:flutter_bmflocation/flutter_baidu_location_ios_option.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:museumguide/models/index.dart';
import 'package:video_player/video_player.dart';
import 'package:museumguide/common/global.dart';

final _firestore = Firestore.instance;

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leadingWidth: 90,
            leading: FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, 'my_videos');
              },
              child: Text("我的视频"),
            ),
            title: Text("视频浏览"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'video_select_page');
                },
                child: Text("发布视频"),
              ),
            ],
          ),
          body: Column(
            children: [
              MessagesStream(),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('VideoCollection').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<VideoList> messageBubbles = [];
        for (var message in messages) {
          final title = message.data['title'];
          final introduction = message.data['introduction'];
          final url = message.data['url'];
          final submitTime = message.data['time'];
          final name = message.data['username'];

          final messageBubble = VideoList(
            title: title,
            introduction: introduction,
            url: url,
            time: submitTime,
            name: name,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: Container(
            child: ListView.separated(
             // reverse: true,
              itemBuilder: (context,i){
                return messageBubbles[i];
              },
              separatorBuilder: (context,i)=>Divider(),
              itemCount: messageBubbles.length,
            ),
          ),
        );
      },
    );
  }
}

class VideoList extends StatefulWidget {
  VideoList({this.title, this.introduction, this.url, this.time,this.name});
  final String title;
  final String introduction;
  final String url;
  String time;
  String name;

  @override
  _VideoListState createState() => _VideoListState(title: title,time: time,url: url,introduction: introduction,name: name);
}

class _VideoListState extends State<VideoList> {
  _VideoListState({this.title, this.introduction, this.url, this.time,this.name});
  final String title;
  final String introduction;
  final String url;
  String time;
  String name;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  void initState() {
    super.initState();
    // 生成控制器(两个)
    _videoPlayerController1 = VideoPlayerController.network('$url.mp4');
    _videoPlayerController1.initialize();
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        autoPlay: false,
        looping: true,
        aspectRatio: 16 / 9);
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController1.dispose();
    _chewieController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print('time--------'+time);
    time=time.substring(0,time.length-7);
    String username ='唐伯虎';//昵称
    if(Global.user.nickName!=null&&Global.user.nickName!='') {
      username=Global.user.nickName;
    }
    return Container(
      child: Column(
        children: [
          Text(
            '标题：$title',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '简介：$introduction',
            style: TextStyle(fontSize: 15),
          ),
          AspectRatio(
            aspectRatio: _videoPlayerController1.value.aspectRatio,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          Text(
            '发布人：${name +"  发布时间："+ time}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}


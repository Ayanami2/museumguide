import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:museumguide/models/user.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:museumguide/common/global.dart';

final _firestore = Firestore.instance;

class MyVideo extends StatefulWidget {
  @override
  _MyVideoState createState() => _MyVideoState();
}

class _MyVideoState extends State<MyVideo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('我的视频'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
        ),
        body: Column(children: [
          MessagesStream(),
        ]),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String username = '唐伯虎'; //昵称
    if (Global.user.nickName != null && Global.user.nickName != '') {
      username = Global.user.nickName;
    }
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(Global.user.IDNumber).snapshots(),
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

          final messageBubble = VideoList(
            title: title,
            introduction: introduction,
            url: url,
            time: submitTime,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, i) {
              return messageBubbles[i];
            },
            separatorBuilder: (context, i) => Divider(),
            itemCount: messageBubbles.length,
          ),
        );
      },
    );
  }
}

/*
class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VideoList(title: '故宫', introduction: '故宫博物院');
  }
}*/

class VideoList extends StatefulWidget {
  VideoList({this.title, this.introduction, this.url, this.time});

  final String title;
  final String introduction;
  final String url;
  String time;

  @override
  _VideoListState createState() =>
      _VideoListState(
          title: title, time: time, url: url, introduction: introduction);
}

class _VideoListState extends State<VideoList> {
  _VideoListState({this.title, this.introduction, this.url, this.time});

  final String title;
  final String introduction;
  final String url;
  String time;
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
    print('time--------' + time);
    time = time.substring(0, time.length - 7);
    String username = '唐伯虎'; //昵称
    if (Global.user.nickName != null && Global.user.nickName != '') {
      username = Global.user.nickName;
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
            '发布人：${username + "  发布时间：" + time}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

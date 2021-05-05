import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';

final _firestore = Firestore.instance;
String username='swgk';
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
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded),
          ),
        ),
        body: Container(
          height: 300,
          width: 360,
          child: MessagesStream(),
        ),
      ),
    );
  }
}
/*
class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(username).snapshots(),
      builder: ( context,snapshot) {
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
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
*/

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VideoList(title: '故宫',introduction: '故宫博物院');

  }
}

class VideoList extends StatelessWidget{
  VideoList({this.title, this.introduction, this.url,this.time}){
    _videoPlayerController1 = VideoPlayerController.network(
        'https://img.dpm.org.cn/Uploads/video/8dazuo_hubiao.mp4'
    );
    _videoPlayerController1.initialize();
  }

  final String title;
  final String introduction;
  final String url;
  final String time;
  VideoPlayerController _videoPlayerController1;


  @override
  void dispose() {
    _videoPlayerController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: Chewie(
              controller:ChewieController(videoPlayerController: _videoPlayerController1,
                  autoPlay: true,
                  looping: true,
                  aspectRatio: 16/9),
            ),
          ),
          Container(
            color: Colors.grey[350],
            child: Text('$title',
            style: TextStyle(fontSize: 20),),
          ),
          Text('$username',
            style: TextStyle(fontSize: 10),),
        ],
      ),
    );
  }
}
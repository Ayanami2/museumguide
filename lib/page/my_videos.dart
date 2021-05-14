import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:museumguide/models/user.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:museumguide/common/global.dart';
import 'package:museumguide/service/video_service.dart';
import 'package:museumguide/models/video.dart';

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
    return StreamBuilder<List<Video>>(
      stream: getVideoList(accountNumber: Global.user.accountNumber),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data;
        List<VideoList> messageBubbles = [];
        for (var message in messages) {
          final title = message.videoName;
          final introduction = message.intro;
          final url = message.address;
          final state = message.state;
          final acNumber = message.accountNumber;
          final nickname = message.nickName;

          final messageBubble = VideoList(
            title: title,
            introduction: introduction,
            url: url,
            state: state,
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
  VideoList({this.title, this.introduction, this.url, this.state});

  final String title;
  final String introduction;
  final String url;
  final num state;
  //String time;

  @override
  _VideoListState createState() => _VideoListState(
      title: title, url: url, introduction: introduction, state: state);
}

class _VideoListState extends State<VideoList> {
  _VideoListState({this.title, this.introduction, this.url, this.state});

  final String title;
  final String introduction;
  final String url;
  final num state;
  final List<String> states = ['未审核', '通过', '未通过'];
  //String time;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  void initState() {
    super.initState();
    // 生成控制器(两个)
    _videoPlayerController1 = VideoPlayerController.network(url);
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

  Color setColor({num videoState}) {
    var textColor;
    if (videoState == -1) {
      textColor = Colors.grey;
    } else if (videoState == 0) {
      textColor = Colors.green;
    } else if (videoState == 1) {
      textColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    //print('time--------' + time);
    //time = time.substring(0, time.length - 7);
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
            '发布人：$username',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            '状态：${states[state + 1]}',
            style: TextStyle(fontSize: 13, color: setColor(videoState: state)),
          ),
          // Text(
          //   '发布人：${username + "  发布时间：" + time}',
          //   style: TextStyle(fontSize: 10),
          // ),
        ],
      ),
    );
  }
}

Stream<List<Video>> getVideoList({num accountNumber}) async* {
  var userVideoList = await VideoService.getVideoListByAccountNumber(
      accountNumber: accountNumber);
  yield userVideoList;
}

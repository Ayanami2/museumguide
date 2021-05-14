import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:museumguide/models/index.dart';
import 'package:video_player/video_player.dart';
import 'package:museumguide/common/global.dart';
import 'package:museumguide/service/video_service.dart';
import 'package:museumguide/models/video.dart';

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
    return StreamBuilder<List<Video>>(
      stream: getVideoList(),
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
            name: nickname,
            state: state,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: Container(
            child: ListView.separated(
              // reverse: true,
              itemBuilder: (context, i) {
                return messageBubbles[i];
              },
              separatorBuilder: (context, i) => Divider(),
              itemCount: messageBubbles.length,
            ),
          ),
        );
      },
    );
  }
}

class VideoList extends StatefulWidget {
  VideoList({this.title, this.introduction, this.url, this.name,this.state});

  final String title;
  final String introduction;
  final String url;
  final num state;
  //String time;
  String name;

  @override
  _VideoListState createState() => _VideoListState(
      title: title,
      url: url,
      introduction: introduction,
      name: name);
}

class _VideoListState extends State<VideoList> {
  _VideoListState(
      {this.title, this.introduction, this.url,this.name,this.state});

  final String title;
  final String introduction;
  final String url;
  final num state;
  //String time;
  String name;
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

  @override
  Widget build(BuildContext context) {
    // print('time--------' + time);
    // time = time.substring(0, time.length - 7);
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
            '发布人：$name',
            style: TextStyle(fontSize: 10),
          ),
          // Text(
          //   '发布人：${name + "  发布时间：" + time}',
          //   style: TextStyle(fontSize: 10),
          // ),
        ],
      ),
    );
  }
}

Stream<List<Video>> getVideoList() async* {
  var userVideoList = await VideoService.getVideoList();
  yield userVideoList;
}
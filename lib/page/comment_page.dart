import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:video_player/video_player.dart';

final _firestore = Firestore.instance;
String username = "swgk";

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
            reverse: true,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class VideoList extends StatelessWidget {
  VideoList({this.title, this.introduction, this.url, this.time}) {
    _videoPlayerController1 = VideoPlayerController.network('$url.mp4');
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
    return Column(
      children: [
        Chewie(
          controller: ChewieController(
              videoPlayerController: _videoPlayerController1,
              autoPlay: false,
              looping: true,
              aspectRatio: 16 / 9),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        Text(
          '${username + time}',
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}

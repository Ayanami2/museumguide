import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class VideoSelectPage extends StatefulWidget {
  @override
  _VideoSelectPageState createState() => _VideoSelectPageState();
}

class _VideoSelectPageState extends State<VideoSelectPage> {
  final titleTextController = TextEditingController();
  final introductionTextController = TextEditingController();
  String title;
  String introuction;
  bool k1=false;
  bool k2=false;
  bool k3=false;

  File _video;
  ImagePicker picker = ImagePicker();
  VideoPlayerController _videoPlayerController;


  _pickVideo() async {
    print(222);
    print(MediaQuery.of(context).size.width);
    PickedFile video =
    await picker.getVideo(source: ImageSource.gallery);
    _video = File(video.path);
    //print(video);
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text("视频上传"),
          ),
          body: Column(children: [
            if (_video != null)
              _videoPlayerController.value.initialized
                  ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
                  : Container(
              ),

            Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setWidth(360),
              child: FlatButton(
                onPressed: () {
                  _pickVideo();
                },
                child: Text("选择视频"),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: ScreenUtil().setHeight(1),
                    color: Colors.black45,
                  ),
                )
              ],
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("标题:",
                    style: TextStyle(
                        fontSize: 20
                    ),),
                  Expanded(
                    child: TextField(
                      maxLength: 10,
                      maxLengthEnforced: true,
                      style: TextStyle(fontSize: 20),
                      controller: titleTextController,
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        hintText: '请填写标题',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ]),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: ScreenUtil().setHeight(1),
                    color: Colors.black45,
                  ),
                )
              ],
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("简介:",
                    style: TextStyle(
                        fontSize: 20
                    ),),
                  Expanded(
                    child: TextField(
                      maxLines: 4,
                      maxLength: 40,
                      maxLengthEnforced: true,
                      style: TextStyle(fontSize: 20),
                      controller: introductionTextController,
                      onChanged: (value) {
                        introuction = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
                        hintText: '请填简介',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ]),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: ScreenUtil().setHeight(1),
                    color: Colors.black45,
                  ),
                )
              ],
            ),
            Center(
              child: FlatButton(
                onPressed: (){
                  ///上传视频
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    "发布",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


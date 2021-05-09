import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:museumguide/models/user.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:museumguide/utils/image_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:museumguide/common/global.dart';

final _firestore = Firestore.instance;


class VideoSelectPage extends StatefulWidget {
  @override
  _VideoSelectPageState createState() => _VideoSelectPageState();
}

class _VideoSelectPageState extends State<VideoSelectPage> {

  final titleTextController = TextEditingController();
  final introductionTextController = TextEditingController();

  String title;
  String introuction;
  String username;
  bool k1 = false;
  bool k3 = false;
  String getURL;
  var urll;

  File _video;
  ImagePicker picker = ImagePicker();
  VideoPlayerController _videoPlayerController;
  var thumbnailPath;

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  _pickVideo() async {

    PickedFile video = await picker.getVideo(
        source: ImageSource.gallery, maxDuration: const Duration(seconds: 10));
    _video = File(video.path);
    print(111);
    print(_video.path);
    print(222);
    thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: video.path,
        imageFormat: ImageFormat.PNG,
        maxWidth: 128,
        quality: 25);
    print('thumbnailPath');
    if (thumbnailPath == null)
      print("kongkong");
    else
      print(thumbnailPath);

    print(thumbnailPath);
    _videoPlayerController = VideoPlayerController.file(_video);

    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  Future<void> putFileToStorage(
      File file, String type, String name, String folder) async {
    String username ='唐伯虎';//昵称
    if(Global.user.nickName!=null&&Global.user.nickName!='') {
      username=Global.user.nickName;
    }
    print(type);
    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('$username/$folder/$name');
    final StorageUploadTask task = firebaseStorageRef.putFile(file);
    await task.onComplete;
    getURL = await firebaseStorageRef.getDownloadURL();

    print("uri:" + getURL.toString());
    k3 = true;
    print('k3:' + k3.toString());

    _firestore.collection('VideoCollection').add({
      'idNumber': Global.user.IDNumber,
      'username': username,
      'title': title,
      'introduction': introuction,
      'url': getURL,
      'time': DateTime.now().toString(),
    });
    print('geturl' + getURL);
    k3 = true;
    print('k3:' + k3.toString());

    _firestore.collection('${Global.user.IDNumber}').add({
      'title': title,
      'introduction': introuction,
      'url': getURL,
      'time': DateTime.now().toString(),
    });
  }

  Widget BOX() {
    if (_video == null)
      return Container(
        width: ScreenUtil().setWidth(360.0),
        height: ScreenUtil().setHeight(203.0),
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage("resource/boder.png"),
        ),
      );
    if (_video != null) {
      _videoPlayerController.initialize();
      return AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
        child: Chewie(
          controller: ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: false,
            looping: true,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String username ='唐伯虎';//昵称
    if(Global.user.nickName!=null&&Global.user.nickName!='') {
     username=Global.user.nickName;
    }
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink[300],
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text("视频上传"),
            actions: [
              FlatButton(
                onPressed: () {
                  _pickVideo();
                },
                child: Text("选择视频"),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              BOX(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: ScreenUtil().setHeight(15),
                      color: Colors.black45,
                    ),
                  )
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  "标题:",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: TextField(
                    maxLength: 10,
                    maxLengthEnforced: true,
                    style: TextStyle(fontSize: 20),
                    controller: titleTextController,
                    onChanged: (value) {
                      title = value;
                      if (value != null) k1 = true;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
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
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  "简介:",
                  style: TextStyle(fontSize: 20),
                ),
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 10.0),
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
              Container(
                margin: EdgeInsets.all(15.0),
                color: Colors.blue,
                child: FlatButton(
                  onPressed: () async {
                    if (_video == null)
                      showDialog<Null>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text('请选择要上传的视频'),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  '知道了',
                                  style: TextStyle(color: Colors.pinkAccent),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    else if (k1 == false) {
                      showDialog<Null>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text('请填写稿件标题'),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text(
                                  '知道了',
                                  style: TextStyle(color: Colors.pinkAccent),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else if (_video != null) {
                      String name = _video.path
                          .split('/')[_video.path.split('/').length - 1];
                      print(name);
                      String type = _video.path
                          .split('/')[_video.path.split('/').length - 1]
                          .split('.')[_video.path
                          .split('/')[_video.path.split('/').length - 1]
                          .split('.')
                          .length -
                          1];
                      print(type);
                      await FirebaseAuth.instance.signInAnonymously();
                      await putFileToStorage(
                          _video, type, title, 'camera_video');
                      if (k3)
                        showDialog<Null>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text('上传成功'),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text(
                                    '知道了',
                                    style: TextStyle(color: Colors.pinkAccent),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .popAndPushNamed('comment_page');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                    }

                    ///上传视频
                    ///
                  },
                  child: Text(
                    "发布",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}


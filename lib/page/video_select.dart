import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:museumguide/utils/image_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  File _video;
  ImagePicker picker = ImagePicker();
  VideoPlayerController _videoPlayerController;
  var thumbnailPath;

  _pickVideo() async {
    username = "swgk";
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
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  Future<void> putFileToStorage(
      File file, String type, String name, String folder) async {
    print(type);
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$username/$folder/$name');
    final StorageUploadTask task = firebaseStorageRef.putFile(file);
    getURL = await firebaseStorageRef.getDownloadURL();
    print('geturl' + getURL);
    k3 = true;
    print('k3:' + k3.toString());

    _firestore.collection('${username}').document("test").setData({
      'title': title,
      'introduction': introuction,
      'url': getURL,
      'time': DateTime.now(),
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
      _videoPlayerController.value.initialized;
      return AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: VideoPlayer(_videoPlayerController),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              /*
              if (_video != null)
                _videoPlayerController.value.initialized
                    ? AspectRatio(
                  aspectRatio: 16.0/9.0,
                  child: VideoPlayer(_videoPlayerController),
                )
                    : Container(
                ),

             Portrait(
              radius: 20,
              imageProvider:
              Image.memory(ImageUtil.base642Image(thumbnailPath))
                  .image,
            ),
              FutureBuilder(
                future: thumbnailPath,
                  builder: (context,snapshot){
                    if (!snapshot.hasData) {
                      return Portrait(
                        radius: 20,
                        imageProvider: NetworkImage(
                            'http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg'),
                      );
                    }

                return Portrait(
                  radius: 20,
                  imageProvider:
                  Image.memory(ImageUtil.base642Image(snapshot.data))
                      .image,
                );
              }),*/

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

class Portrait extends StatelessWidget {
  Portrait({this.radius, this.imageProvider});

  final double radius;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundColor: Colors.redAccent,
      backgroundImage: imageProvider,
    );
  }
}

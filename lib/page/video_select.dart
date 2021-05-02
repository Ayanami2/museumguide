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
  bool k1=false;
  bool k2=false;
  bool k3=false;

  File _video;
  ImagePicker picker = ImagePicker();
  VideoPlayerController _videoPlayerController;
  var thumbnailPath;

  _pickVideo() async {
    username="swg";
    PickedFile video =
    await picker.getVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 10));
    _video = File(video.path);
    print(111);
    print(_video.path);
    print(222);
    thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: video.path,
        imageFormat: ImageFormat.PNG,
        maxWidth: 128,
        quality: 25
    );
    print('thumbnailPath');
    if(thumbnailPath==null)
      print("kongkong");
    else print(thumbnailPath);

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
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('$username/$folder/$name');
    final StorageUploadTask task = firebaseStorageRef.putFile(file);
    String ss=await firebaseStorageRef.getDownloadURL();
    print('ss:');
    print(ss);
    /*
    _firestore.collection('${user.email}' + '_' + '$toUser').add({
      'text': 'you are sending $name ...',
      'sender': user.email,
      'time': DateTime.now(),
    });

*/
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
                onPressed: (){
                  _pickVideo();
                },
                child: Text("选择视频"),
              ),
            ],
          ),
          body: Column(children: [

            if (_video != null)
              _videoPlayerController.value.initialized
                  ? AspectRatio(
                aspectRatio: 16.0/9.0,
                child: VideoPlayer(_videoPlayerController),
              )
                  : Container(
              ),

      /*      Portrait(
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
            Container(
              color: Colors.blue,
              child: FlatButton(
                onPressed: () async {

                  if(_video!=null){
                    String name=_video.path.split('/')[_video.path.split('/').length-1];
                    print(name);
                    String type=_video.path
                        .split('/')[_video.path.split('/').length - 1]
                        .split('.')[_video.path
                        .split('/')[_video.path.split('/').length - 1]
                        .split('.')
                        .length -
                        1];
                    print(type);
                   await FirebaseAuth.instance.signInAnonymously();
                    await putFileToStorage(_video, type, name,'camera_video');
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
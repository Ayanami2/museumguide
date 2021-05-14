import 'package:museumguide/models/index.dart';
import 'package:museumguide/config/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoService {
  static Future<List<Video>> getVideoListByAccountNumber({
    num accountNumber,
  }) async {
    final response = await http.post(
      ServerUrl.VIDEO_URL,
      body: {
        "action": "getVideoListByAccountNumber",
        "accountNumber": accountNumber.toString(),
      },
    );
    var list = jsonDecode(response.body);
    List<Video> res = [];
    for (var obj in list) {
      res.add(Video.fromJson(obj));
    }
    return res;
  }

  static void insertVideo({
    Video insertedVideo,
  }) async {
    final response = await http.post(
      ServerUrl.VIDEO_URL,
      body: {
        "action": "insertVideo",
        "nickName": insertedVideo.nickName ?? "none",
        "accountNumber": insertedVideo.accountNumber.toString(),
        "videoName": insertedVideo.videoName,
        "intro": insertedVideo.intro ?? "none",
        "address": insertedVideo.address ?? "none",
        "state": (-1).toString(),
      },
    );
    print(response.body);
  }

  static Future<List<Video>> getVideoList() async {
    final response = await http.post(
      ServerUrl.VIDEO_URL,
      body: {
        "action": "getVideoList",
      },
    );
    var list = jsonDecode(response.body);
    List<Video> res = [];
    for (var obj in list) {
      res.add(Video.fromJson(obj));
    }
    return res;
  }
}

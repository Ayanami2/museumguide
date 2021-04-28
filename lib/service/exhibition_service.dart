import 'package:museumguide/models/index.dart';
import 'package:museumguide/config/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExhibitionService {
  static Future<Exhibition> getExhibitionByExhibitionID({
    num exhibitionID,
  }) async {
    final response = await http.post(
      ServerUrl.EXHIBITION_URL,
      body: {
        "action": "getExhibitionByExhibitionID",
        "exhibitionID": exhibitionID.toString(),
      },
    );
    print(response.body);
    return Exhibition.fromJson(jsonDecode(response.body));
  }

  static Future<List<Exhibition>> getExhibitionListByMuseumID({
    num museumID,
  }) async {
    final response = await http.post(ServerUrl.EXHIBITION_URL, body: {
      "action": "getExhibitionListByMuseumID",
      "museumID": museumID.toString(),
    });
    var list = jsonDecode(response.body);
    List<Exhibition> res = [];
    for (var obj in list) {
      res.add(Exhibition.fromJson(obj));
    }
    return res;
  }
}

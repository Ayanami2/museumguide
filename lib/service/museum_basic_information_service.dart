import 'package:museumguide/models/index.dart';
import 'package:museumguide/config/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MuseumBasicInformationService {
  static Future<MuseumBasicInformation> getMuseumByMuseumID({
    num museumID,
  }) async {
    final response = await http.post(
      ServerUrl.MUSEUM_BASIC_INFORMATION_URL,
      body: {
        "action": "getMuseumByMuseumID",
        "museumID": museumID,
      },
    );
    print(MuseumBasicInformation.fromJson(jsonDecode(response.body)).museumID);
    return MuseumBasicInformation.fromJson(jsonDecode(response.body));
  }

  static Future<List<MuseumBasicInformation>> getMuseumList() async {
    final response =
        await http.post(ServerUrl.MUSEUM_BASIC_INFORMATION_URL, body: {
      "action": "getMuseumList",
    });
    print(response.body);
    var list = jsonDecode(response.body);
    print(list.runtimeType);
    List<MuseumBasicInformation> res = [];
    for (var obj in list) {
      res.add(MuseumBasicInformation.fromJson(obj));
    }
    return res;
  }
}

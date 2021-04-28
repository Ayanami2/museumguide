import 'package:museumguide/models/index.dart';
import 'package:museumguide/config/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CollectionService {
  static Future<Collection> getCollectionByCollectionID({
    num collectionID,
  }) async {
    final response = await http.post(
      ServerUrl.COLLECTION_URL,
      body: {
        "action": "getCollectionByCollectionID",
        "collectionID": collectionID.toString(),
      },
    );
    // print(response.body);
    return Collection.fromJson(jsonDecode(response.body));
  }

  static Future<List<Collection>> getCollectionListByMuseumID({
    num museumID,
  }) async {
    final response = await http.post(ServerUrl.COLLECTION_URL, body: {
      "action": "getCollectionListByMuseumID",
      "museumID": museumID.toString(),
    });
    var list = jsonDecode(response.body);
    List<Collection> res = [];
    for (var obj in list) {
      res.add(Collection.fromJson(obj));
    }
    return res;
  }
}

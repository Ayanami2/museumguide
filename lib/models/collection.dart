import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection {
  Collection();

  num collectionID;
  num museumID;
  String collectionIntroduction;
  String collectionImageLink;
  String collectionName;
  String museumName;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}

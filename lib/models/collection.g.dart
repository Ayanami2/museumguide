// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return Collection()
    ..collectionID = int.parse(json['collectionID']) as num
    ..collectionName = json['collectionName'] as String
    ..collectionIntroduction = json['collectionIntroduction'] as String
    ..collectionImageLink = json['collectionImageLink'] as String
    ..museumID = int.parse(json['museumID']) as num
    ..museumName = json['museumName'] as String;
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'collectionID': instance.collectionID,
      'collectionName': instance.collectionName,
      'collectionIntroduction': instance.collectionIntroduction,
      'collectionImageLink': instance.collectionImageLink,
      'museumID': instance.museumID,
      'museumName': instance.museumName,
    };

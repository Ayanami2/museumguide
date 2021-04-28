// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exhibition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exhibition _$ExhibitionFromJson(Map<String, dynamic> json) {
  return Exhibition()
    ..exhibitionID = int.parse(json['exhibitionID']) as num
    ..exhibitionName = json['exhibitionName'] as String
    ..exhibitionIntroduction = json['exhibitionIntroduction'] as String
    ..exhibitionTime = json['exhibitionTime'] as String
    ..exhibitionImageLink = json['exhibitionImageLink'] as String
    ..museumID = int.parse(json['museumID']) as num
    ..museumName = json['museumName'] as String;
}

Map<String, dynamic> _$ExhibitionToJson(Exhibition instance) =>
    <String, dynamic>{
      'exhibitionID': instance.exhibitionID,
      'exhibitionName': instance.exhibitionName,
      'exhibitionIntroduction': instance.exhibitionIntroduction,
      'exhibitionTime': instance.exhibitionTime,
      'exhibitionImageLink': instance.exhibitionImageLink,
      'museumID': instance.museumID,
      'museumName': instance.museumName,
    };

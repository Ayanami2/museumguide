// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'museumBasicInformation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MuseumBasicInformation _$MuseumBasicInformationFromJson(
    Map<String, dynamic> json) {
  return MuseumBasicInformation()
    ..museumID = int.parse(json['museumID']) as num
    ..museumName = json['museumName'] as String
    ..openingTime = json['openingTime'] as String
    ..address = json['address'] as String
    ..consultationTelephone = json['consultationTelephone'] as String
    ..introduction = json['introduction'] as String
    ..longitude = json['longitude'] as String
    ..latitude = json['latitude'] as String
    ..publicityVideoLink = json['publicityVideoLink'] as String;
}

Map<String, dynamic> _$MuseumBasicInformationToJson(
        MuseumBasicInformation instance) =>
    <String, dynamic>{
      'museumID': instance.museumID,
      'museumName': instance.museumName,
      'openingTime': instance.openingTime,
      'address': instance.address,
      'consultationTelephone': instance.consultationTelephone,
      'introduction': instance.introduction,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'publicityVideoLink': instance.publicityVideoLink,
    };

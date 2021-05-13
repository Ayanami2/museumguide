// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) {
  return Video()
    ..nickName = json['NickName'] as String
    ..accountNumber = int.parse(json['AccountNumber']) as num
    ..videoName = json['VideoName'] as String
    ..intro = json['Intro'] as String
    ..address = json['Address'] as String
    ..state = int.parse(json['State']) as num;
}

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'nickName': instance.nickName,
      'accountNumber': instance.accountNumber,
      'videoName': instance.videoName,
      'intro': instance.intro,
      'address': instance.address,
      'state': instance.state,
    };

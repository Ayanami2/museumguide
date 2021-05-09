// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..nickName = json['NickName'] as String
    ..IDNumber = json['IDNumber'] as String
    ..name = json['Name'] as String
    ..permission = int.parse(json['Permission']) as num
    ..accountNumber = int.parse(json['AccountNumber']) as num
    ..password = json['Password']
    ..phoneNumber = json['PhoneNumber']
    ..email = json['E_mail']
    ..state = int.parse(json['State']) as num;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nickName': instance.nickName,
      'IDNumber': instance.IDNumber,
      'name': instance.name,
      'permission': instance.permission,
      'accountNumber': instance.accountNumber,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'state': instance.state,
    };

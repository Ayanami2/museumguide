import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  String nickName;

  // ignore: non_constant_identifier_names
  String IDNumber;
  String name;
  num permission;
  num accountNumber;
  String password;
  String phoneNumber;
  String email;
  num state;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

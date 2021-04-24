import 'package:json_annotation/json_annotation.dart';

part 'museumBasicInformation.g.dart';

@JsonSerializable()
class MuseumBasicInformation {
  MuseumBasicInformation();

  num museumID;
  String museumName;
  String openingTime;
  String address;
  String consultationTelephone;
  String introduction;
  String longitude;
  String latitude;
  String publicityVideoLink;

  factory MuseumBasicInformation.fromJson(Map<String, dynamic> json) =>
      _$MuseumBasicInformationFromJson(json);

  Map<String, dynamic> toJson() => _$MuseumBasicInformationToJson(this);
}

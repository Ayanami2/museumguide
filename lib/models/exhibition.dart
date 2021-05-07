import 'package:json_annotation/json_annotation.dart';

part 'exhibition.g.dart';

@JsonSerializable()
class Exhibition {
    Exhibition();

  num exhibitionID;
  String exhibitionName;
  String exhibitionTime;
  String exhibitionIntroduction;
  num museumID;
  String museumName;
  String exhibitionImageLink;

  factory Exhibition.fromJson(Map<String, dynamic> json) =>
      _$ExhibitionFromJson(json);

  Map<String, dynamic> toJson() => _$ExhibitionToJson(this);
}

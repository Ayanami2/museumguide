import 'package:flutter/material.dart';
import '../../service/index.dart';
import '../../models/index.dart';

class ExhibitionDetailInformation extends StatelessWidget {
  final Exhibition exhibition;

  ExhibitionDetailInformation({Key key, this.exhibition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(exhibition.exhibitionImageLink),
          Row(
            children: [
              Text(exhibition.exhibitionName),
              Text(exhibition.exhibitionTime),
            ],
          ),
          Text(exhibition.exhibitionIntroduction),
        ],
      ),
    );
  }
}

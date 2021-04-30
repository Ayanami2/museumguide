import 'package:flutter/material.dart';

class MuseumExhibitionInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: null,
          separatorBuilder: (context, i) => Divider(),
          itemCount: 10),
    );
  }
}

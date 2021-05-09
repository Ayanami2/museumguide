import 'package:flutter/material.dart';

class Portrait extends StatelessWidget {
  Portrait({this.radius, this.imageProvider});

  final double radius;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundColor: Colors.redAccent,
      backgroundImage: imageProvider,
    );
  }
}

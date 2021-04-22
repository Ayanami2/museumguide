import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Portrait extends StatelessWidget {
  Portrait({this.radius,this.imageProvider});
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

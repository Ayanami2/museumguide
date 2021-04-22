import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerLineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      //颜色
      color: Colors.grey[350],
      //高度
      height: ScreenUtil().setHeight(1.0),
    );
  }
}
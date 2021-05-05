///author:ana
///updateDate:2021/3/23
///updateBy:ana

import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

class ImageUtil {
  ///图片转Base64存储
  ///
  ///参数为File类型的图片,使用该图片方法为Image.file()
  static Future<String> image2Base64(File file) async {
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  ///Base64转图片显示
  ///
  ///使用该图片方法为Image.memory()
  static Uint8List base642Image(String base64Str) {
    Uint8List bytes = base64.decode(base64Str);
    return bytes;
  }
}

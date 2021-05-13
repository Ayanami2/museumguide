import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumguide/service/index.dart';
import 'package:museumguide/models/index.dart';
import 'package:museumguide/common/global.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {

  //旧密码的控制器
  TextEditingController lastpasswordController = TextEditingController();

  //新密码的控制器
  TextEditingController newpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('更改密码'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: TextField(
                controller: lastpasswordController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.lock),
                  labelText: '请输入旧密码',
                ),
                obscureText: true),
            margin: const EdgeInsets.only(left: 30,top:20,right:30),
          ),
          Container(
            child: TextField(
                controller: newpasswordController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.lock),
                  labelText: '请输入新密码',
                ),
                obscureText: true),
            margin: const EdgeInsets.only(left: 30,right:30),
          ),
          Container(
            child: RaisedButton(
              onPressed: _setting,
              child: Text('确认'),
            ),
            margin: const EdgeInsets.only(left: 120,top:30,right:120),
          ),
        ],
      ),
    );
  }

  void _setting() async {
    print({'lastpassword': lastpasswordController.text,
      'newpassword': newpasswordController.text});
     if (lastpasswordController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('请填写旧密码'),
          ));
    }else if(lastpasswordController.text.length > 0) {
      User user = Global.user;
      if (user == null || user.password != lastpasswordController.text) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('密码错误'),
                ));
        onTextClear();
      }else if (newpasswordController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('请填写新密码'),
          ));

    } else {
      UserService.updatePassword(
        accountNumber: user.accountNumber,
        password: newpasswordController.text,
      );
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('更改密码成功'),
          ));
      onTextClear();
    }
    }
  }

  void onTextClear() {
    setState(() {
      lastpasswordController.clear();
      newpasswordController.clear();
    });
  }
}

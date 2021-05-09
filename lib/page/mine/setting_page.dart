import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumguide/service/index.dart';
import 'package:museumguide/models/index.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  //手机号的控制器
  TextEditingController accountNumberController = TextEditingController();
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
          TextField(
            controller: accountNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.account_box_outlined),
              labelText: '请输入你的账号（最多11位）',
            ),
            autofocus: false,
          ),
          TextField(
              controller: lastpasswordController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.lock),
                labelText: '请输入旧密码',
              ),
              obscureText: true),
          TextField(
              controller: newpasswordController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.lock),
                labelText: '请输入新密码',
              ),
              obscureText: true),
          RaisedButton(
            onPressed: _setting,
            child: Text('确认'),
          ),
        ],
      ),
    );
  }

  void _setting() async {
    print({'accountNumber': accountNumberController.text,
      'lastpassword': lastpasswordController.text,
      'newpassword': newpasswordController.text});
    if (accountNumberController.text.length == 0||accountNumberController.text.length>11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('账号格式不对'),
          ));
    } else if (lastpasswordController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('请填写旧密码'),
          ));
    }else if(lastpasswordController.text.length > 0){
      User user = await UserService.getUserByAccountNumber(
          accountNumber: int.parse(accountNumberController.text));
      if (user == null || user.password != lastpasswordController.text) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('密码错误'),
            ));
        onTextClear();
      }
    else if (newpasswordController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('请填写新密码'),
          ));

    } else {
      UserService.updatePassword(
        accountNumber: int.parse(accountNumberController.text),
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
      accountNumberController.clear();
      lastpasswordController.clear();
      newpasswordController.clear();
    });
  }
}
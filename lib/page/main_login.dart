import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museumguide/common/global.dart';
import 'package:museumguide/service/index.dart';
import 'package:museumguide/models/index.dart';

class MainLoginPage extends StatefulWidget {
  @override
  _MainLoginPageState createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        child: Container(
          child: buildBody(),
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  buildBody() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Image.asset(
            "images/login.jpg",
            fit: BoxFit.fill,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
        Positioned(
          bottom: 160,
          left: 60,
          right: 60,
          child: buildColumn(),
        ),
        Positioned(
          top: 160,
          child: Text(
            "博物馆导览",
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlatButton(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border.all(color: Colors.white)),
            child: Text(
              "注册",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            height: 54,
            alignment: Alignment.center,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            Navigator.pushNamed(context, 'register_page');
          },
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                height: 1.0,
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 4, right: 4),
              child: Text(
                "注册过的用户可以直接登录",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 20),
                height: 1.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        FlatButton(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border.all(color: Colors.white)),
            child: Text(
              "登录",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            height: 54,
            alignment: Alignment.center,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            Navigator.pushNamed(context, 'login_page');
          },
        ),
      ],
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController nickNameController = TextEditingController();
  TextEditingController IDNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController twicepasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册账户'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: TextField(
              controller: accountNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.account_box_outlined),
                labelText: '请输入你想要注册的账号（最多11位）',
              ),
              autofocus: false,
            ),
            margin: const EdgeInsets.only(left: 30, top: 20, right: 30),
          ),
          Container(
            child: TextField(
                controller: passwordController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.lock),
                  labelText: '请输入密码',
                ),
                obscureText: true),
            margin: const EdgeInsets.only(left: 30, right: 30),
          ),
          Container(
            child: TextField(
                controller: twicepasswordController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.lock),
                  labelText: '请再次输入密码',
                ),
                obscureText: true),
            margin: const EdgeInsets.only(left: 30, right: 30),
          ),
          Container(
            child: TextField(
              controller: nickNameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.account_box),
                  labelText: '请输入你的昵称',
                  hintText: '可以不填'),
            ),
            margin: const EdgeInsets.only(left: 30, right: 30),
          ),
          Container(
            child: TextField(
              controller: IDNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.perm_identity),
                labelText: '请输入你的身份证号',
              ),
            ),
            margin: const EdgeInsets.only(left: 30, right: 30),
          ),
          Container(
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.account_circle),
                  labelText: '请输入你的姓名',
                  hintText: '可以不填'),
            ),
            margin: const EdgeInsets.only(left: 30, right: 30),
          ),
          Container(
            child: TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.phone),
                labelText: '请输入你的手机号',
                hintText: '可以不填',
              ),
            ),
            margin: const EdgeInsets.only(left: 30, right: 30),
          ),
          Container(
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.email),
                labelText: '请输入你的电子邮箱',
                hintText: '可以不填',
              ),
            ),
            margin: const EdgeInsets.only(left: 30, right: 30),
          ),
          Container(
            child: RaisedButton(
              onPressed: _register,
              child: Text('确认'),
            ),
            margin: const EdgeInsets.only(left: 120, top: 30, right: 120),
          ),
        ],
      ),
    );
  }

  void _register() async {
    print({
      'nickName': nickNameController,
      'IDNumber': IDNumberController.text,
      'name': nameController.text,
      'accountNumber': accountNumberController.text,
      'password': passwordController.text,
      'twicepassword': twicepasswordController.text,
      'phoneNumber': phoneNumberController.text,
      'email': emailController.text
    });
    if (accountNumberController.text.length == 0 ||
        accountNumberController.text.length > 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('账号格式不对'),
              ));
    } else if (accountNumberController.text.length > 0) {
      bool isExist = await UserService.isUserExist(
          searchedAccountNumber: accountNumberController.text);
      if (isExist == false) {
        if (passwordController.text.length == 0) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('请填写密码'),
                  ));
        } else if (twicepasswordController.text.length == 0) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('请再次输入密码'),
                  ));
        } else if (twicepasswordController.text != passwordController.text) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('两次输入的密码不相同'),
                  ));
          passwordController.clear();
          twicepasswordController.clear();
        } else if (IDNumberController.text.length != 18) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('身份证号格式不对'),
                  ));
          IDNumberController.clear();
        } else {
          UserService.insertUser(
              insertedUser: User()
                ..accountNumber = int.parse(accountNumberController.text)
                ..password = passwordController.text
                ..nickName = nickNameController.text
                ..IDNumber = IDNumberController.text
                ..name = nameController.text
                ..phoneNumber = phoneNumberController.text
                ..email = emailController.text);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('注册成功'),
                  ));
          onTextClear();
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("该账号已被注册"),
                ));
        accountNumberController.clear();
      }
    }
  }

  void onTextClear() {
    setState(() {
      accountNumberController.clear();
      passwordController.clear();
      twicepasswordController.clear();
      nameController.clear();
      nickNameController.clear();
      IDNumberController.clear();
      phoneNumberController.clear();
      emailController.clear();
    });
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: TextField(
              controller: accountNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.account_box_outlined),
                labelText: '请输入你的账号（最多11位）',
              ),
              autofocus: false,
            ),
            margin: const EdgeInsets.only(left: 30, top: 20, right: 30),
          ),
          Container(
            child: TextField(
                controller: passwordController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.lock),
                  labelText: '请输入密码',
                ),
                obscureText: true),
            margin: const EdgeInsets.only(left: 30, right: 30),
          ),
          Container(
            child: RaisedButton(
              onPressed: _login,
              child: Text('登录'),
            ),
            margin: const EdgeInsets.only(left: 120, top: 30, right: 120),
          ),
        ],
      ),
    );
  }

  void _login() async {
    print({
      'accountNumber': accountNumberController.text,
      'password': passwordController.text
    });
    if (accountNumberController.text.length == 0 ||
        accountNumberController.text.length > 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('账号格式不对'),
              ));
    } else {
      bool isExist = await UserService.isUserExist(
          searchedAccountNumber: accountNumberController.text);
      if (isExist == false) {
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text("账号不存在"),
                ));
        onTextClear();
      } else {
        if (passwordController.text.length == 0) {
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('请填写密码'),
                ));
      } else {
        User user = await UserService.getUserByAccountNumber(
            accountNumber: int.parse(accountNumberController.text));
        if (user != null && user.password == passwordController.text) {
          Global.user = user;
          Navigator.pushNamed(context, 'home_page');
        } else {
          showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: Text('密码错误'),
                  ));
          onTextClear();
        }
      }
    }
    }
  }

  void onTextClear() {
    setState(() {
      accountNumberController.clear();
      passwordController.clear();
    });
  }
}

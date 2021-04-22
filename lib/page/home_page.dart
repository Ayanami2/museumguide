///author:ana
///updateDate:2021/4/1
///updateBy:ana
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museumguide/config/bottom_lab_icon.dart';
import 'mine/mine_page.dart';
import 'comment_page.dart';
import 'map_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;

  var _body;

  var _pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = <Widget>[
      MapPage(),
      CommentPage(),
      MinePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
      return _buildBody(context);
  }

  Icon getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return BottomTabIcon.TAB_ICON[curIndex][1];
    }
    return BottomTabIcon.TAB_ICON[curIndex][0];
  }

  Widget _buildBody(context) {
    _body = IndexedStack(
      children: _pages,
      index: _tabIndex,
    );
    return Scaffold(
      body: _body,
      bottomNavigationBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getTabIcon(0)),
          BottomNavigationBarItem(icon: getTabIcon(1)),
          BottomNavigationBarItem(icon: getTabIcon(2)),
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}

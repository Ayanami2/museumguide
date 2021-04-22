import 'package:museumguide/page/comment_page.dart';
import 'package:museumguide/page/home_page.dart';
import 'package:museumguide/page/map_page.dart';
import 'package:museumguide/page/mine/mine_page.dart';
final routes={
  '/': (context) => (HomePage()),
  'comment_page': (context) => (CommentPage()),
  'map_page': (context) => (MapPage()),
  'mine_page': (context) => (MinePage()),
};
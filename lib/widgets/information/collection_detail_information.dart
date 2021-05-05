import 'package:flutter/material.dart';
import '../../service/index.dart';
import '../../models/index.dart';

class CollectionDetailInformation extends StatelessWidget {
  final Collection collection;

  CollectionDetailInformation({Key key, this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(collection.collectionName),
          Text(collection.collectionImageLink),
          Text(collection.collectionIntroduction)
        ],
      ),
    );
  }
}

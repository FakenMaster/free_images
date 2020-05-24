import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchHintWidget extends StatelessWidget {
  const SearchHintWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Colors.green[200], size: 80.0),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              "输入关键字搜索内容",
              style: TextStyle(
                color: Colors.green[100],
              ),
            ),
          )
        ],
      ),
    );
  }
}
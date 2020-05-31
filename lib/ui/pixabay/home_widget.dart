import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/bloc/pixabay/bloc/pixabay_bloc.dart';
import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/model/pixabay/pixabay_model.dart';
import 'package:free_images/route/image_route.gr.dart';
import 'package:rxdart/rxdart.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

/// 背景图片数据保存到本地，使用SharedPreference或者文件或者数据库，个人推荐数据库，上次那个hive吧
class _HomeWidgetState extends State<HomeWidget>
    with AutomaticKeepAliveClientMixin {
  PixabayBloc bloc;
  List<ImageItem> items = [];
  int page = 1;
  BehaviorSubject<int> behaviorSubject;
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    bloc = PixabayBloc();
    behaviorSubject = BehaviorSubject.seeded(0);
  }

  @override
  void dispose() {
    textController.dispose();
    bloc.dispose();
    behaviorSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/home_sunset.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 16,
              top: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    'assets/images/pixabay_logo.png',
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment(0, -0.4),
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.black,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: textController,
                        autofocus: false,
                        textInputAction: TextInputAction.search,
                        cursorColor: Colors.white.withOpacity(0.8),
                        cursorWidth: 1,
                        onSubmitted: _search,
                        decoration: InputDecoration(
                          hintText: 'Search free images...',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    
                    GestureDetector(
                      onTap: () {
                        _search(textController.text);
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _search(String term) {
    ExtendedNavigator.of(context).pushNamed(Routes.pixabaySearchWidget,
        arguments: PixabaySearchWidgetArguments(
            term: (term?.isNotEmpty ?? false) ? term : null));
  }

  @override
  bool get wantKeepAlive => true;
}

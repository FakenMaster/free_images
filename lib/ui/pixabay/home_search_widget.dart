import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/bloc/pixabay/bloc/pixabay_bloc.dart';
import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/model/pixabay/pixabay_model.dart';
import 'package:free_images/route/image_route.gr.dart';
import 'package:rxdart/rxdart.dart';

class HomeSearchWidget extends StatefulWidget {
  @override
  _HomeSearchWidgetState createState() => _HomeSearchWidgetState();
}

/// 背景图片数据保存到本地，使用SharedPreference或者文件或者数据库，个人推荐数据库，上次那个hive吧
class _HomeSearchWidgetState extends State<HomeSearchWidget> {
  PixabayBloc bloc;
  List<ImageItem> items = [];
  int page = 1;
  BehaviorSubject<int> behaviorSubject;

  @override
  void initState() {
    super.initState();
    bloc = PixabayBloc();
    //Future.delayed(Duration(seconds: 1)).then((value) => bloc.search());
    behaviorSubject = BehaviorSubject.seeded(0);
  }

  @override
  void dispose() {
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
            StreamBuilder<PixabayState>(
              stream: bloc.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data is PixabayResultState) {
                  PixabayModel<ImageItem> model =
                      (snapshot.data as PixabayResultState).data;
                  items.addAll(model.hits);
                  return StreamBuilder(
                      stream: behaviorSubject.stream,
                      builder: (context, snapshot) {
                        ImageItem imageItem = items[behaviorSubject.value];
                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            ExtendedNavigator.of(context).pushNamed(
                                Routes.viewImageWidget,
                                arguments: ViewImageWidgetArguments(
                                    heroTag: imageItem.largeImageUrl,
                                    url: imageItem.largeImageUrl));
                          },
                          child: Image.network(
                            imageItem.webformatUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        );
                      });
                }
                return Container();
              },
            ),
            Positioned(
              left: 16,
              top: 16,
              right: 16,
              //bottom: 16,
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
              alignment: Alignment(0, -0.3),
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.black,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autofocus: false,
                        textInputAction: TextInputAction.search,
                        cursorColor: Colors.white.withOpacity(0.8),
                        cursorWidth: 1,
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
                    Icon(
                      Icons.search,
                      color: Colors.white,
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
}

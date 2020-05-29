import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:free_images/bloc/pixabay/bloc/pixabay_bloc.dart';
import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/model/pixabay/pixabay_model.dart';
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
    Future.delayed(Duration(seconds: 1)).then((value) => bloc.search(''));
    behaviorSubject = BehaviorSubject.seeded(0);
  }

  @override
  void dispose() {
    bloc.dipose();
    behaviorSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    return GestureDetector(
                      onTap: () {
                        int nextIndex = behaviorSubject.value + 1;
                        if (nextIndex >= items.length) {
                          bloc.search('', page: ++page);
                        }
                        behaviorSubject
                            .add((behaviorSubject.value + 1) % items.length);
                      },
                      child: Image.network(
                        items[behaviorSubject.value].largeImageUrl,
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ],
    );
  }
}

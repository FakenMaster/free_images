import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/bloc/pixabay/bloc/pixabay_bloc.dart';
import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/route/image_route.gr.dart';
import 'package:free_images/util/util.dart';
import 'package:rxdart/rxdart.dart';

class PixabaySearchWidget extends StatefulWidget {
  final String term;
  final String category;

  const PixabaySearchWidget({Key key, this.term, this.category})
      : super(key: key);

  @override
  _PixabaySearchWidgetState createState() => _PixabaySearchWidgetState();
}

class Pair extends Equatable {
  final int size;
  final int page;

  Pair(this.size, this.page);

  @override
  List<Object> get props => [size, page];
}

class _PixabaySearchWidgetState extends State<PixabaySearchWidget> {
  BehaviorSubject<int> selectedIndexSubject;
  BehaviorSubject<Pair> imageSizeSubject;
  PixabayBloc bloc;
  ScrollController scrollController;

  String term;

  @override
  void initState() {
    super.initState();
    term = widget.term;

    scrollController = ScrollController()
      ..addListener(() {
        ScrollPosition position = scrollController.position;
        if (position.maxScrollExtent - position.pixels < 300) {
          //bloc.loadMore();
          print('最大滑动距离:${position.maxScrollExtent},当前滑动距离:${position.pixels}');
          bloc.search(
              term: term,
              popular: selectedIndexSubject.value == 0,
              editorChoice: false,
              category: term == null ? widget.category : '',
              page: imageSizeSubject.value.page + 1);
        }
      });
    bloc = PixabayBloc();
    imageSizeSubject = BehaviorSubject()..startWith(Pair(0, 1));
    bloc.stream.listen((state) {
      if (state is PixabayResultState) {
        imageSizeSubject.add(Pair(state.data.total, state.page));
      } else {
        imageSizeSubject.add(Pair(0, 1));
      }
    });
    selectedIndexSubject = BehaviorSubject()
      ..distinct().listen((index) {
        bloc.search(
          term: '',
          popular: index == 0,
          editorChoice: false,
          category: term == null ? widget.category : '',
        );
      });
    selectedIndexSubject
      ..delay(Duration(seconds: 1))
      ..add(0);
  }

  @override
  void dispose() {
    bloc.dispose();
    imageSizeSubject.close();
    selectedIndexSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PixabayStyles.colorDark,
      body: SafeArea(
        child: Column(
          children: [
            //搜索框
            Container(
              height: 48,
              color: PixabayStyles.colorLight,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                      child: Stack(
                    children: [
                      Visibility(
                        visible: false,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        'TestTestTestTestTestTestTEstTeTTEstTesetTestTetset',
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              //controller: textController,
                              autofocus: false,
                              textInputAction: TextInputAction.search,
                              cursorColor: Colors.white.withOpacity(0.8),
                              cursorWidth: 1,
                              //onSubmitted: _search,
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                tabItem('Popular', 0),
                tabItem('Latest', 1),
                Expanded(
                  child: Container(),
                ),
                Row(
                  children: <Widget>[
                    StreamBuilder(
                      stream: imageSizeSubject.stream,
                      builder: (context, snapshot) {
                        return Container(
                          padding: EdgeInsets.only(top: 6.0),
                          child: Text(
                            '${(snapshot.data?.size ?? 0).toString().delimiter3CharReverse()} images',
                            style: TextStyle(
                              color: PixabayStyles.colorGrey,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 16,
                    )
                  ],
                )
              ],
            ),
            // gridView
            Expanded(
              child: Container(
                color: Colors.black,
                child: StreamBuilder(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    PixabayState state = snapshot.data;

                    if (snapshot.hasData) {
                      if (state is PixabayResultState) {
                        return _staggerGridView(state.data.hits);
                      } else if (state is PixabayLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _staggerGridView(List<ImageItem> data) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 170, crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemBuilder: (context, index) {
        ImageItem imageItem = data[index];
        return GestureDetector(
          onTap: () {
            ExtendedNavigator.of(context).pushNamed(Routes.viewImageWidget,
                arguments: ViewImageWidgetArguments(
                  url: imageItem.largeImageUrl,
                  previewUrl: imageItem.webformatUrl,
                ));
          },
          child: CachedNetworkImage(
            imageUrl: data[index].webformatUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Container(
                color: PixabayStyles.colorLight,
              );
            },
          ),
        );
      },
      itemCount: data.length,
    );
  }

  Widget tabItem(String text, int index) {
    return GestureDetector(
      onTap: () {
        selectedIndexSubject.add(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 8),
        padding: const EdgeInsets.only(top: 16, right: 8),
        child: Column(
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: PixabayStyles.colorGrey,
                fontSize: 13,
              ),
            ),
            StreamBuilder(
              stream: selectedIndexSubject.stream,
              builder: (context, snapshot) {
                int selectedIndex = snapshot.data ?? 0;
                return AnimatedOpacity(
                  opacity: index == selectedIndex ? 1 : 0,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    width: 60,
                    height: 2,
                    margin: EdgeInsets.only(top: 4, bottom: 6),
                    color: Colors.blue,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

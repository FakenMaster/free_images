import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/bloc/pixabay/bloc/pixabay_bloc.dart';
import 'package:free_images/ui/pixabay/pixabay_list_widget.dart';
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
  BehaviorSubject<bool> searchTermSubject;

  String term;

  TextEditingController textEditingController;

  search({bool refresh = true}) {
    bloc.search(
        term: term,
        popular: selectedIndexSubject.value == 0,
        editorChoice: false,
        category: term == null ? widget.category : '',
        page: refresh ? null : imageSizeSubject.value.page + 1);
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    term = widget.term;
    searchTermSubject = BehaviorSubject.seeded(false);
    scrollController = ScrollController()
      ..addListener(() {
        ScrollPosition position = scrollController.position;
        if (position.maxScrollExtent - position.pixels < 300) {
          search(refresh: false);
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
        search();
      });
    selectedIndexSubject
      ..delay(Duration(seconds: 1))
      ..add(0);
  }

  @override
  void dispose() {
    bloc.dispose();
    textEditingController.dispose();
    imageSizeSubject.close();
    selectedIndexSubject.close();
    searchTermSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (searchTermSubject.value) {
          searchTermSubject.add(false);
          setState(() {});
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
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
                        if (searchTermSubject.value) {
                          searchTermSubject.add(false);
                          setState(() {});
                        } else {
                          Navigator.of(context).pop();
                        }
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
                          visible: true,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 250),
                            child: StreamBuilder(
                              stream: searchTermSubject,
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data) {
                                  return _searchTextField();
                                } else {
                                  return _showSearchTerm();
                                }
                              },
                            ),
                          ),
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
                      print('有新数据啦');
                      if (snapshot.hasData) {
                        if (state is PixabayResultState) {
                          return PixabayListWidget(
                              state.data.hits, scrollController);
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
      ),
    );
  }

  Widget _showSearchTerm() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              textEditingController.text = term;
              searchTermSubject.add(true);
              setState(() {});
            },
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      term ?? widget.category ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    textEditingController.text = '';
                    searchTermSubject.add(true);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.more_vert,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget _searchTextField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textEditingController,
            autofocus: true,
            textInputAction: TextInputAction.search,
            cursorColor: Colors.white.withOpacity(0.8),
            cursorWidth: 1,
            onSubmitted: (_) {
              searchNewTerm();
            },
            decoration: InputDecoration(
              hintText: 'Search free images...',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            searchNewTerm();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
          ),
        )
      ],
    );
  }

  searchNewTerm() {
    term = textEditingController.text;
    searchTermSubject.add(false);
    FocusScope.of(context).unfocus();
    setState(() {});
    search();
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

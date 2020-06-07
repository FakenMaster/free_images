import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/bloc/pixabay/bloc/pixabay_bloc.dart';
import 'package:free_images/ui/pixabay/pixabay_list_widget.dart';
import 'package:free_images/util/util.dart';
import 'package:rxdart/rxdart.dart';

class EditorChoiceWidget extends StatefulWidget {
  @override
  _EditorChoiceWidgetState createState() => _EditorChoiceWidgetState();
}

class Pair extends Equatable {
  final int size;
  final int page;

  Pair(this.size, this.page);

  @override
  List<Object> get props => [size, page];
}

class _EditorChoiceWidgetState extends State<EditorChoiceWidget>
    with AutomaticKeepAliveClientMixin {
  BehaviorSubject<int> selectedIndexSubject;
  BehaviorSubject<Pair> imageSizeSubject;
  PixabayBloc bloc;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        ScrollPosition position = scrollController.position;
        if (position.maxScrollExtent - position.pixels < 300) {
          //bloc.loadMore();
          print('最大滑动距离:${position.maxScrollExtent},当前滑动距离:${position.pixels}');
          bloc.search(
              term: '',
              popular: selectedIndexSubject.value == 0,
              editorChoice: true,
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
        bloc.search(term: '', popular: index == 0, editorChoice: true);
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
      backgroundColor: Color(0xff404040),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 8, top: 10, bottom: 2),
              color: Color(0xff585858),
              width: double.infinity,
              child: Text(
                "Editor's Choice",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
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

  @override
  bool get wantKeepAlive => true;
}

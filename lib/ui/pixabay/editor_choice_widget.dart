import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/bloc/pixabay/bloc/pixabay_bloc.dart';
import 'package:free_images/util/styles.dart';
import 'package:rxdart/rxdart.dart';

class EditorChoiceWidget extends StatefulWidget {
  @override
  _EditorChoiceWidgetState createState() => _EditorChoiceWidgetState();
}

class _EditorChoiceWidgetState extends State<EditorChoiceWidget> {
  int imageSizes = 0;

  BehaviorSubject<int> selectedIndexSubject;
  PixabayBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PixabayBloc();

    selectedIndexSubject = BehaviorSubject()
      ..distinct().listen((index) {
        print('新数据啦$index');
        bloc.search(term: '', popular: index == 0, editorChoice: true);
      })
      ..startWith(0);
  }

  @override
  void dispose() {
    bloc.dispose();
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
                    Text(
                      '$imageSizes images',
                      style: TextStyle(
                        color: PixabayStyles.colorGrey,
                      ),
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
        padding: const EdgeInsets.only(top: 12, right: 8),
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

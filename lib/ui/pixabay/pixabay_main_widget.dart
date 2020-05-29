import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/ui/pixabay/category_widget.dart';
import 'package:free_images/ui/pixabay/editor_choice_widget.dart';
import 'package:free_images/ui/pixabay/home_search_widget.dart';
import 'package:free_images/ui/widget/page_indicator.dart';

class PixabayMainWidget extends StatefulWidget {
  @override
  _PixabayMainWidgetState createState() => _PixabayMainWidgetState();
}

class _PixabayMainWidgetState extends State<PixabayMainWidget> {
  PageController pageController;
  StreamController<int> indexController;

  @override
  void initState() {
    super.initState();
    indexController = StreamController()..add(1);
    pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    indexController.close();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2ecc71),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              EditorChoiceWidget(),
              HomeSearchWidget(),
              CategoryWidget(),
            ],
            onPageChanged: (index) {
              indexController.add(index);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: StreamBuilder(
              stream: indexController.stream,
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: PageIndicator(
                    count: 3,
                    selectedIndex: snapshot.data,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

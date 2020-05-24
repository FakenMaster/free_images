import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/ui/pixabay/pixabay_search_widget.dart';

class HomeTabWidget extends StatefulWidget {
  @override
  _HomeTabWidgetState createState() => _HomeTabWidgetState();
}

class _HomeTabWidgetState extends State<HomeTabWidget> {
  final titles = ['Pixabay', 'Unsplash', 'Giphy'];
  final icons = ['assets/images/pixabay_logo.png'];
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          if (index == 0) {
            return PixabaySearchWidget();
          }
          return Center(
            child: Text(titles[index]),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(_currentIndex);
          });
        },
        items: [
          for (var title in titles)
            BottomNavigationBarItem(
              title: Text(title),
              icon: Icon(Icons.hot_tub)
              // icon: Image.asset(icons[0]),
            ),
        ],
      ),
    );
  }
}

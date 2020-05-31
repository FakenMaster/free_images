import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/api/pixabay/pixabay_api.dart';
import 'package:free_images/route/image_route.gr.dart';
import 'package:free_images/util/util.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff404040),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 8, top: 10, bottom: 2),
              color: PixabayStyles.colorLight,
              width: double.infinity,
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black,
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children: <Widget>[
                    for (String category in PixabayApi.categories)
                      Material(
                        child: InkWell(
                          onTap: () {
                            ExtendedNavigator.of(context).pushNamed(
                                Routes.pixabaySearchWidget,
                                arguments: PixabaySearchWidgetArguments(
                                    category: category));
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Image.asset(
                                  'assets/images/category_$category.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    width: double.infinity,
                                    color: Colors.black.withOpacity(0.4),
                                    child: Text(
                                      category.capitalize(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/api/pixabay/pixabay_api.dart';
import 'package:free_images/util/util.dart';

class CategoryWidget extends StatelessWidget {
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
                      Stack(
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
}

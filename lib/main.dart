import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:free_images/route/image_route.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Free Images',
      builder: (context, child) => Theme(
        data: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        child: ExtendedNavigator<ImageRouter>(router: ImageRouter()),
      ),
    );
  }
}

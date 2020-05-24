import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class ViewImageWidget extends StatelessWidget {
  final Object heroTag;
  final String url;

  const ViewImageWidget({Key key, this.heroTag, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Hero(
          tag: heroTag,
          child: PhotoView(
            onTapUp: (_,__,___){
              Navigator.pop(context);
            },
            imageProvider: NetworkImage(url),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class ViewImageWidget extends StatelessWidget {
  final Object heroTag;
  final String url;
  final String previewUrl;

  const ViewImageWidget({Key key, this.heroTag, this.url, this.previewUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Hero(
          tag: heroTag ?? url,
          child: PhotoView.customChild(
            minScale: 1.0,
            maxScale: 5.0,
            // onTapUp: (_, __, ___) {
            //   Navigator.pop(context);
            // },
            child: CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) {
                return CachedNetworkImage(
                  imageUrl: previewUrl,
                );
              },
            ),
          ),
          //     PhotoView(
          //   minScale: 0.1,
          //   maxScale: 5.0,
          //   imageProvider: CachedNetworkImageProvider(
          //     url,
          //   ),),
        ),
      ),
    );
  }
}

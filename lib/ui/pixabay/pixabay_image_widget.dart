import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/model/pixabay/pixabay_model.dart';
import 'package:free_images/route/image_route.gr.dart';

class PixabayImageWidget extends StatelessWidget {
  final PixabayModel<ImageItem> images;
  PixabayImageWidget(this.images);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        final item = images.hits[index];
        return Hero(
          tag: item.id,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                ExtendedNavigator.of(context).pushNamed(Routes.viewImageWidget,
                    arguments: ViewImageWidgetArguments(
                        heroTag: item.id, url: item.largeImageUrl));
              },
              child: Image.network(
                item.webformatUrl,
              ),
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
      ),
      itemCount: images?.hits?.length ?? 0,
    );
  }
}

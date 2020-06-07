import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/route/image_route.gr.dart';
import 'package:free_images/util/content/styles.dart';

class PixabayListWidget extends StatelessWidget {
  final List<ListImageItemData> list = [];
  final ScrollController scrollController;

  PixabayListWidget(List<ImageItem> data, this.scrollController) {
    for (int i = 0; i < data.length; i += 2) {
      List<ImageItem> items = []..addAll(data.sublist(i, i + 2));
      list.add(ListImageItemData(items));
    }
  }

  List<Widget> listImageItemWidget(
      ListImageItemData itemData, BuildContext context) {
    List<Widget> widgets = [];
    if (itemData.images.isNotEmpty) {
      for (int i = 0; i < itemData.images.length - 1; i++) {
        widgets
          ..add(Expanded(
            flex: itemData.flexes[i],
            child: AspectRatio(
                aspectRatio: itemData.aspectRatios[i],
                child: imageItemWidget(itemData.images[i], context)),
          ))
          ..add(SizedBox(
            width: 4,
          ));
      }

      int index = itemData.images.length - 1;
      widgets.add(Expanded(
        flex: itemData.flexes[index],
        child: AspectRatio(
            aspectRatio: itemData.aspectRatios[index],
            child: imageItemWidget(itemData.images[index], context)),
      ));
    }

    return widgets;
  }

  Widget imageItemWidget(ImageItem imageItem, BuildContext context) {
    bool heightLargerThanWidth =
        imageItem.previewHeight > imageItem.previewWidth;
    return GestureDetector(
      onTap: () {
        ExtendedNavigator.of(context).pushNamed(Routes.viewImageWidget,
            arguments: ViewImageWidgetArguments(
              url: imageItem.largeImageUrl,
              previewUrl: imageItem.webformatUrl,
            ));
      },
      child: CachedNetworkImage(
        imageUrl: imageItem.webformatUrl,
        fit: heightLargerThanWidth ? BoxFit.cover : BoxFit.cover,
        placeholder: (context, url) {
          return Container(
            color: PixabayStyles.colorLight,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        ListImageItemData itemData = list[index];
        return Column(
          children: [
            Container(
              height: itemData.hasHeightLargerThanWidth ? 150 : 100,
              child: Row(
                children: listImageItemWidget(itemData, context),
              ),
            ),
            SizedBox(
              height: 4,
            )
          ],
        );
      },
      itemCount: list.length,
    );
  }
}

class ListImageItemData {
  List<ImageItem> images = [];
  bool hasHeightLargerThanWidth = false;
  List<int> flexes = [];
  List<double> aspectRatios = [];

  ListImageItemData(this.images) {
    hasHeightLargerThanWidth = images
        .any((element) => element.webformatWidth < element.webformatHeight);
    images.forEach((ImageItem image) {
      aspectRatios.add(image.previewWidth / image.previewHeight.toDouble());
      bool heightLargerThanWidth = image.previewWidth < image.previewHeight;

      flexes.add((hasHeightLargerThanWidth
              ? heightLargerThanWidth
                  ? image.previewWidth
                  : (image.previewWidth * 150 / image.previewHeight)
              : image.previewHeight)
          .toInt());
    });
  }
}

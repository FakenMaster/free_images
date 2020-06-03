import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/model/pixabay/pixabay_model.dart';
import 'package:free_images/route/image_route.gr.dart';

class PixabayImageWidget extends StatefulWidget {
  final PixabayModel<ImageItem> images;
  PixabayImageWidget(this.images);

  @override
  _PixabayImageWidgetState createState() => _PixabayImageWidgetState();
}

class _PixabayImageWidgetState extends State<PixabayImageWidget> {
  ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController()
      ..addListener(() {
        double offset = controller.offset;
        ScrollPosition position = controller.position;
        print("偏移值:$offset , 位置:$position");
        print(
            "${position.minScrollExtent},${position.maxScrollExtent},已经滑动:${position.pixels}");
      });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Expanded(
            child: GridView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                final item = widget.images.hits[index];
                return Hero(
                  tag: item.id,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ExtendedNavigator.of(context).pushNamed(
                            Routes.viewImageWidget,
                            arguments: ViewImageWidgetArguments(
                                heroTag: item.id, url: item.largeImageUrl));
                      },
                      child: Image.network(
                        item.webformatUrl,
                        // loadingBuilder: (context, child, event) {
                        //   return Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // },
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
              itemCount: widget.images?.hits?.length ?? 0,
            ),
          ),
        ),
        SliverVisibility(
          visible: false,
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

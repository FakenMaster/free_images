import 'package:auto_route/auto_route_annotations.dart';
import 'package:free_images/ui/pixabay/pixabay_search_widget.dart';
import 'package:free_images/ui/ui.dart';
import 'package:free_images/ui/widget/view_image_widget.dart';

@MaterialAutoRouter()
class $ImageRouter {
  @initial
  HomeTabWidget homeTab;

  PixabaySearchWidget pixabaySearchWidget;
  ViewImageWidget viewImageWidget;
}

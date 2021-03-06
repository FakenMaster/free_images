import 'package:auto_route/auto_route_annotations.dart';
import 'package:free_images/ui/pixabay/pixabay_main_widget.dart';
import 'package:free_images/ui/pixabay/pixabay_search_widget.dart';
import 'package:free_images/ui/pixabay/pixabay_tab_widget.dart';
import 'package:free_images/ui/ui.dart';
import 'package:free_images/ui/widget/view_image_widget.dart';

@MaterialAutoRouter()
class $ImageRouter {
  //@initial
  HomeTabWidget homeTab;

  PixabayTabWidget pixabayTabWidget;
  ViewImageWidget viewImageWidget;
  @initial
  PixabayMainWidget pixabayMainWidget;
  PixabaySearchWidget pixabaySearchWidget;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:free_images/ui/home_tab/home_tab.dart';
import 'package:free_images/ui/pixabay/pixabay_search_widget.dart';
import 'package:free_images/ui/widget/view_image_widget.dart';

abstract class Routes {
  static const homeTab = '/';
  static const pixabaySearchWidget = '/pixabay-search-widget';
  static const viewImageWidget = '/view-image-widget';
  static const all = {
    homeTab,
    pixabaySearchWidget,
    viewImageWidget,
  };
}

class ImageRouter extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<ImageRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.homeTab:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeTabWidget(),
          settings: settings,
        );
      case Routes.pixabaySearchWidget:
        return MaterialPageRoute<dynamic>(
          builder: (context) => PixabaySearchWidget(),
          settings: settings,
        );
      case Routes.viewImageWidget:
        if (hasInvalidArgs<ViewImageWidgetArguments>(args)) {
          return misTypedArgsRoute<ViewImageWidgetArguments>(args);
        }
        final typedArgs =
            args as ViewImageWidgetArguments ?? ViewImageWidgetArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => ViewImageWidget(
              key: typedArgs.key,
              heroTag: typedArgs.heroTag,
              url: typedArgs.url),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//ViewImageWidget arguments holder class
class ViewImageWidgetArguments {
  final Key key;
  final Object heroTag;
  final String url;
  ViewImageWidgetArguments({this.key, this.heroTag, this.url});
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/bloc/pixabay/bloc/pixabay_bloc.dart';
import 'package:free_images/route/image_route.gr.dart';
import 'package:free_images/ui/pixabay/pixabay_image_widget.dart';
import 'package:free_images/ui/widget/empty_widget.dart';
import 'package:free_images/ui/widget/error_widget.dart';
import 'package:free_images/ui/widget/loading_widget.dart';
import 'package:free_images/ui/widget/search_hint.dart';

class PixabaySearchWidget extends StatefulWidget {
  @override
  _PixabaySearchWidgetState createState() => _PixabaySearchWidgetState();
}

class _PixabaySearchWidgetState extends State<PixabaySearchWidget>
    with AutomaticKeepAliveClientMixin {
  PixabayBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PixabayBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            RaisedButton(
              onPressed: () => ExtendedNavigator.of(context)
                  .pushNamed(Routes.pixabayMainWidget),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: false,
                      style: TextStyle(fontSize: 20, color: Colors.green[200]),
                      decoration: InputDecoration(),
                      onChanged: (String text) {
                        bloc.search(term: text);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<PixabayState>(
                stream: bloc.stream,
                builder: (context, snapshot) => _buildChild(snapshot.data),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChild(PixabayState state) {
    if (state == null || state is PixabayInitial) {
      return SearchHintWidget();
    } else if (state is PixabayLoadingState) {
      return LoadingWidget();
    } else if (state is PixabayEmptyState) {
      return EmptyWidget();
    } else if (state is PixabayErrorState) {
      return SearchErrorWidget();
    } else if (state is PixabayResultState) {
      return PixabayImageWidget(state.data);
    }
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}

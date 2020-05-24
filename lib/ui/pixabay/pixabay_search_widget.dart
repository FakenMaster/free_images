import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free_images/bloc/pixabay/bloc/pixabay_bloc.dart';
import 'package:free_images/ui/pixabay/pixabay_image_widget.dart';
import 'package:free_images/ui/widget/empty_widget.dart';
import 'package:free_images/ui/widget/error_widget.dart';
import 'package:free_images/ui/widget/loading_widget.dart';
import 'package:free_images/ui/widget/search_hint.dart';

class PixabaySearchWidget extends StatefulWidget {
  @override
  _PixabaySearchWidgetState createState() => _PixabaySearchWidgetState();
}

class _PixabaySearchWidgetState extends State<PixabaySearchWidget> {
  PixabayBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PixabayBloc();
    Future.delayed(Duration(seconds: 2),(){
      bloc.search("");
    });
  }

  @override
  void dispose() {
    bloc.dipose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pixabay'),
      ),
      body: StreamBuilder<PixabayState>(
        stream: bloc.stream,
        builder: (context, snapshot) => _buildChild(snapshot.data),
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
    } 
    else if(state is PixabayErrorState){
      return SearchErrorWidget();
    }
    else if (state is PixabayResultState) {
      return PixabayImageWidget(state.data);
    } 
    return Container();
  }
}

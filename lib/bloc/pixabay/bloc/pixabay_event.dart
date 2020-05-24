part of 'pixabay_bloc.dart';

abstract class PixabayEvent extends Equatable {
  const PixabayEvent();
}

class PixabaySearchEvent extends PixabayEvent {
  final bool searchImage;
  final String term;
  final int page;

  PixabaySearchEvent({this.searchImage = true,this.term, this.page});

  @override
  List<Object> get props => [];
}

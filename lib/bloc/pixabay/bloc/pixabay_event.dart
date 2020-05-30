part of 'pixabay_bloc.dart';

abstract class PixabayEvent extends Equatable {
  const PixabayEvent();
}

class PixabaySearchEvent extends PixabayEvent {
  final bool searchImage;
  final String term;
  final int page;
  final bool editorChoice;
  final bool popular;
  final String category;

  PixabaySearchEvent(
      {this.searchImage = true,
      this.term,
      this.page,
      this.editorChoice,
      this.popular,
      this.category});

  @override
  List<Object> get props =>
      [searchImage, term, page, editorChoice, popular, category];
}

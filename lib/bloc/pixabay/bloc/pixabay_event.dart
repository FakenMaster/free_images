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
      this.page = 1,
      this.editorChoice,
      this.popular,
      this.category});

  PixabaySearchEvent copyWith(
      {bool searchImage,
      String term,
      int page,
      bool editorChoice,
      bool popular,
      String category}) {
    return PixabaySearchEvent(
      searchImage: searchImage ?? this.searchImage,
      term: term ?? this.term,
      page: page ?? this.page,
      editorChoice: editorChoice ?? this.editorChoice,
      popular: popular ?? this.popular,
      category: category ?? this.category,
    );
  }

  @override
  List<Object> get props =>
      [searchImage, term, page, editorChoice, popular, category];
}

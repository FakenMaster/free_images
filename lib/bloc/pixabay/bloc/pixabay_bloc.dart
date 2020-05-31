import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:free_images/api/pixabay/pixabay_api.dart';
import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/model/pixabay/pixabay_model.dart';
import 'package:free_images/repository/pixabay/pixabay_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'pixabay_event.dart';
part 'pixabay_state.dart';

// class PixabayBloc extends Bloc<PixabayEvent, PixabayState> {

//   @override
//   PixabayState get initialState => PixabayInitial();

//   @override
//   Stream<PixabayState> mapEventToState(
//     PixabayEvent event,
//   ) async* {}
// }

class PixabayBloc {
  BehaviorSubject<PixabayEvent> _onTextChange;
  Stream<PixabayState> stream;
  PixabayRepository _pixabayRepository;
  List<ImageItem> images = [];
  PixabayBloc() {
    _pixabayRepository = PixabayRepository(PixabayApi.getInstance());
    _onTextChange = BehaviorSubject<PixabayEvent>();
    stream = _onTextChange
        .distinct()
        .debounceTime(Duration(milliseconds: 500))
        .switchMap<PixabayState>((event) {
      return _search(event);
    }).startWith(PixabayInitial());
  }

  search(
      {String term,
      bool searchImage = true,
      int page = 1,
      bool editorChoice = false,
      bool popular = true,
      String category}) {
    _onTextChange.add(PixabaySearchEvent(
        searchImage: searchImage,
        term: term,
        page: page,
        editorChoice: editorChoice,
        popular: popular,
        category: category));
  }

  loadMore() {
    PixabaySearchEvent lastEvent = _onTextChange.value;
    _onTextChange.add(lastEvent.copyWith(page: lastEvent.page + 1));
  }

  Stream<PixabayState> _search(PixabayEvent event) async* {
    if (event is PixabaySearchEvent) {
      if (event.page == 1) {
        images.clear();
        yield PixabayLoadingState();
      }
      try {
        var result = await (event.searchImage
            ? _pixabayRepository.searchImage(
                q: event.term,
                page: event.page,
                editorChoice: event.editorChoice,
                popular: event.popular,
                category: event.category,
                perPage: kIsWeb?100:40,
              )
            : _pixabayRepository.searchVideo());
        if (result.hits?.isNotEmpty ?? false) {
          yield PixabayResultState(
              result..hits = (images..addAll(result.hits as List<ImageItem>)),
              event.page);
        } else {
          yield PixabayEmptyState();
        }
      } catch (error) {
        yield PixabayErrorState();
      }
    }
  }

  void dispose() {
    _onTextChange?.close();
  }
}

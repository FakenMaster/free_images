import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:free_images/api/pixabay/pixabay_api.dart';
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
  PublishSubject<PixabayEvent> _onTextChange;
  Stream<PixabayState> stream;
  PixabayRepository _pixabayRepository;
  PixabayBloc() {
    _pixabayRepository = PixabayRepository(PixabayApi.getInstance());
    _onTextChange = PublishSubject<PixabayEvent>();
    stream = _onTextChange
        .distinct()
        .debounceTime(Duration(milliseconds: 500))
        .switchMap<PixabayState>((event) {
      return _search(event);
    }).startWith(PixabayInitial());
  }

  search(String term, {bool searchImage = true}) {
    _onTextChange.add(PixabaySearchEvent(searchImage: searchImage, term: term));
  }

  Stream<PixabayState> _search(PixabayEvent event) async* {
    if (event is PixabaySearchEvent) {
      yield PixabayLoadingState();

      try {
        var result = await (event.searchImage
            ? _pixabayRepository.searchImage(q: event.term)
            : _pixabayRepository.searchVideo());
        if (result.hits?.isNotEmpty ?? false) {
          yield PixabayResultState(result);
        } else {
          yield PixabayEmptyState();
        }
      } catch (error) {
        yield PixabayErrorState();
      }
    }
  }

  void dipose() {
    _onTextChange?.close();
  }
}

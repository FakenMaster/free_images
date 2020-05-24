import 'package:free_images/api/pixabay/pixabay_api.dart';
import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/model/pixabay/pixabay_model.dart';

class PixabayRepository {
  final PixabayApi pixabayApi;
  PixabayRepository(this.pixabayApi);
  Future<PixabayModel<ImageItem>> searchImage({
    String q,
    String lang,
    String id,
    bool popular = true,
    int page,
    int perPage,
  }) async =>
      pixabayApi.searchImage(
          q: q,
          lang: lang,
          id: id,
          popular: popular,
          page: page,
          perPage: perPage);

  Future<PixabayModel<ImageItem>> searchVideo({
    String q,
    String lang,
    String id,
    bool popular = true,
    int page,
    int perPage,
  }) async =>
      pixabayApi.searchImage(
          q: q,
          lang: lang,
          id: id,
          popular: popular,
          page: page,
          perPage: perPage);
}

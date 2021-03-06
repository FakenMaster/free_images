import 'package:free_images/api/pixabay/pixabay_api.dart';
import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/model/pixabay/pixabay_model.dart';
import 'package:free_images/model/pixabay/video_item.dart';

class PixabayRepository {
  final PixabayApi pixabayApi;

  PixabayRepository(this.pixabayApi);

  Future<PixabayModel<ImageItem>> searchImage({
    String q,
    String lang,
    String id,
    bool popular = true,
    bool editorChoice = false,
    int page,
    int perPage,
    String category,
  }) async {
    return pixabayApi.searchImage(
        q: q,
        lang: lang,
        id: id,
        popular: popular,
        page: page,
        perPage: perPage,
        category: category,
        editorChoice: editorChoice);
  }

  Future<PixabayModel<VideoItem>> searchVideo({
    String q,
    String lang,
    String id,
    bool popular = true,
    int page,
    int perPage,
  }) async =>
      pixabayApi.searchVideo(
          q: q,
          lang: lang,
          id: id,
          popular: popular,
          page: page,
          perPage: perPage);
}

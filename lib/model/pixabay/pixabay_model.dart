import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/model/pixabay/video_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pixabay_model.g.dart';

Type typeOf<T>() => T;

@JsonSerializable()
class PixabayModel<T> {
  int total;
  int totalHits;

  @_Converter()
  List<T> hits;

  PixabayModel({
    this.total,
    this.totalHits,
    this.hits,
  });

  factory PixabayModel.fromJson(Map<String, dynamic> json) =>
      _$PixabayModelFromJson(json);
  Map<String, dynamic> toJson() => _$PixabayModelToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    //print("json的类型：${json.runtimeType},内容：$json");
    if (json is Map<String, dynamic> && json.containsKey('previewURL')) {
      return ImageItem.fromJson(json) as T;
    } else if (json is Map<String, dynamic> && json.containsKey('videos')) {
      return VideoItem.fromJson(json) as T;
    }
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return null;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object;
  }
}

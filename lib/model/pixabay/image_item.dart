import 'package:json_annotation/json_annotation.dart';
part 'image_item.g.dart';

@JsonSerializable()
class ImageItem {
  int id;
  String pageUrl;
  String type;
  String tags;
  @JsonKey(name: 'previewURL')
  String previewUrl;
  int previewWidth;
  int previewHeight;
  @JsonKey(name: 'webformatURL')
  String webformatUrl;
  int webformatWidth;
  int webformatHeight;
  @JsonKey(name: 'largeImageURL')
  String largeImageUrl;
  @JsonKey(name: 'fullHDURL')
  String fullHdurl;
  @JsonKey(name: 'imageURL')
  String imageUrl;
  int imageWidth;
  int imageHeight;
  int imageSize;
  int views;
  int downloads;
  int favorites;
  int likes;
  int comments;
  int userId;
  String user;
  @JsonKey(name: 'userImageURL')
  String userImageUrl;

  ImageItem({
    this.id,
    this.pageUrl,
    this.type,
    this.tags,
    this.previewUrl,
    this.previewWidth,
    this.previewHeight,
    this.webformatUrl,
    this.webformatWidth,
    this.webformatHeight,
    this.largeImageUrl,
    this.fullHdurl,
    this.imageUrl,
    this.imageWidth,
    this.imageHeight,
    this.imageSize,
    this.views,
    this.downloads,
    this.favorites,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageUrl,
  });

  factory ImageItem.fromJson(Map<String, dynamic> json) =>
      _$ImageItemFromJson(json);
  Map<String, dynamic> toJson() => _$ImageItemToJson(this);
}

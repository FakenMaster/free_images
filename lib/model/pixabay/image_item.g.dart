// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageItem _$ImageItemFromJson(Map<String, dynamic> json) {
  return ImageItem(
    id: json['id'] as int,
    pageUrl: json['pageUrl'] as String,
    type: json['type'] as String,
    tags: json['tags'] as String,
    previewUrl: json['previewURL'] as String,
    previewWidth: json['previewWidth'] as int,
    previewHeight: json['previewHeight'] as int,
    webformatUrl: json['webformatURL'] as String,
    webformatWidth: json['webformatWidth'] as int,
    webformatHeight: json['webformatHeight'] as int,
    largeImageUrl: json['largeImageURL'] as String,
    fullHdurl: json['fullHDURL'] as String,
    imageUrl: json['imageURL'] as String,
    imageWidth: json['imageWidth'] as int,
    imageHeight: json['imageHeight'] as int,
    imageSize: json['imageSize'] as int,
    views: json['views'] as int,
    downloads: json['downloads'] as int,
    favorites: json['favorites'] as int,
    likes: json['likes'] as int,
    comments: json['comments'] as int,
    userId: json['userId'] as int,
    user: json['user'] as String,
    userImageUrl: json['userImageURL'] as String,
  );
}

Map<String, dynamic> _$ImageItemToJson(ImageItem instance) => <String, dynamic>{
      'id': instance.id,
      'pageUrl': instance.pageUrl,
      'type': instance.type,
      'tags': instance.tags,
      'previewURL': instance.previewUrl,
      'previewWidth': instance.previewWidth,
      'previewHeight': instance.previewHeight,
      'webformatURL': instance.webformatUrl,
      'webformatWidth': instance.webformatWidth,
      'webformatHeight': instance.webformatHeight,
      'largeImageURL': instance.largeImageUrl,
      'fullHDURL': instance.fullHdurl,
      'imageURL': instance.imageUrl,
      'imageWidth': instance.imageWidth,
      'imageHeight': instance.imageHeight,
      'imageSize': instance.imageSize,
      'views': instance.views,
      'downloads': instance.downloads,
      'favorites': instance.favorites,
      'likes': instance.likes,
      'comments': instance.comments,
      'userId': instance.userId,
      'user': instance.user,
      'userImageURL': instance.userImageUrl,
    };

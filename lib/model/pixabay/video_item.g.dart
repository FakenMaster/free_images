// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoItem _$VideoItemFromJson(Map<String, dynamic> json) {
  return VideoItem(
    id: json['id'] as int,
    pageUrl: json['pageUrl'] as String,
    type: json['type'] as String,
    tags: json['tags'] as String,
    duration: json['duration'] as int,
    pictureId: json['pictureId'] as String,
    videos: json['videos'] == null
        ? null
        : VideoList.fromJson(json['videos'] as Map<String, dynamic>),
    views: json['views'] as int,
    downloads: json['downloads'] as int,
    favorites: json['favorites'] as int,
    likes: json['likes'] as int,
    comments: json['comments'] as int,
    userId: json['userId'] as int,
    user: json['user'] as String,
    userImageUrl: json['userImageUrl'] as String,
  );
}

Map<String, dynamic> _$VideoItemToJson(VideoItem instance) => <String, dynamic>{
      'id': instance.id,
      'pageUrl': instance.pageUrl,
      'type': instance.type,
      'tags': instance.tags,
      'duration': instance.duration,
      'pictureId': instance.pictureId,
      'videos': instance.videos,
      'views': instance.views,
      'downloads': instance.downloads,
      'favorites': instance.favorites,
      'likes': instance.likes,
      'comments': instance.comments,
      'userId': instance.userId,
      'user': instance.user,
      'userImageUrl': instance.userImageUrl,
    };

VideoList _$VideoListFromJson(Map<String, dynamic> json) {
  return VideoList(
    large: json['large'] == null
        ? null
        : Video.fromJson(json['large'] as Map<String, dynamic>),
    medium: json['medium'] == null
        ? null
        : Video.fromJson(json['medium'] as Map<String, dynamic>),
    small: json['small'] == null
        ? null
        : Video.fromJson(json['small'] as Map<String, dynamic>),
    tiny: json['tiny'] == null
        ? null
        : Video.fromJson(json['tiny'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VideoListToJson(VideoList instance) => <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'small': instance.small,
      'tiny': instance.tiny,
    };

Video _$VideoFromJson(Map<String, dynamic> json) {
  return Video(
    url: json['url'] as String,
    width: json['width'] as int,
    height: json['height'] as int,
    size: json['size'] as int,
  );
}

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
      'size': instance.size,
    };

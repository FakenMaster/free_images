import 'package:json_annotation/json_annotation.dart';
part 'video_item.g.dart';

@JsonSerializable()
class VideoItem {
  int id;
  String pageUrl;
  String type;
  String tags;
  int duration;
  String pictureId;
  VideoList videos;
  int views;
  int downloads;
  int favorites;
  int likes;
  int comments;
  int userId;
  String user;
  String userImageUrl;

  VideoItem({
    this.id,
    this.pageUrl,
    this.type,
    this.tags,
    this.duration,
    this.pictureId,
    this.videos,
    this.views,
    this.downloads,
    this.favorites,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageUrl,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) =>
      _$VideoItemFromJson(json);
  Map<String, dynamic> toJson() => _$VideoItemToJson(this);
}

@JsonSerializable()
class VideoList {
  Video large;
  Video medium;
  Video small;
  Video tiny;

  VideoList({
    this.large,
    this.medium,
    this.small,
    this.tiny,
  });

  factory VideoList.fromJson(Map<String, dynamic> json) =>
      _$VideoListFromJson(json);
  Map<String, dynamic> toJson() => _$VideoListToJson(this);
}

@JsonSerializable()
class Video {
  String url;
  int width;
  int height;
  int size;

  Video({
    this.url,
    this.width,
    this.height,
    this.size,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

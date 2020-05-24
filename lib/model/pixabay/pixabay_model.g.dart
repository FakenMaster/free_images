// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pixabay_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PixabayModel<T> _$PixabayModelFromJson<T>(Map<String, dynamic> json) {
  return PixabayModel<T>(
    total: json['total'] as int,
    totalHits: json['totalHits'] as int,
    hits: (json['hits'] as List)?.map(_Converter<T>().fromJson)?.toList(),
  );
}

Map<String, dynamic> _$PixabayModelToJson<T>(PixabayModel<T> instance) =>
    <String, dynamic>{
      'total': instance.total,
      'totalHits': instance.totalHits,
      'hits': instance.hits?.map(_Converter<T>().toJson)?.toList(),
    };

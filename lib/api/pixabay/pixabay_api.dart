import 'package:free_images/model/pixabay/image_item.dart';
import 'package:free_images/model/pixabay/pixabay_model.dart';
import 'package:free_images/model/pixabay/video_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PixabayApi {
  final baseUrl = "https://pixabay.com";
  final key = "10571224-09a118652b9cca8d9e39ee28b";
  PixabayApi._internal();

  static PixabayApi _instance;
  static PixabayApi _getInstance() {
    return PixabayApi._internal();
  }

  factory PixabayApi.getInstance() {
    if (_instance == null) {
      _instance = _getInstance();
    }
    return _instance;
  }

  Future<PixabayModel<ImageItem>> searchImage({
    String q,
    String lang,
    String id,
    bool popular = true,
    int page,
    int perPage,
  }) async {
    try {
      Map<String, dynamic> params = {
        //"key": key,
        "q": q ?? '',
        //cs, da, de, en, es, fr, id, it, hu, nl, no, pl, pt, ro, sk, fi, sv, tr, vi, th, bg, ru, el, ja, ko, zh
        "lang": lang ?? 'en',
        "id": id ?? '',
        "order": popular ? 'popular' : 'latest',
        'page': page ?? 1,
        'per_page': perPage ?? 20
      };

      String paramsString = "key=$key";
      params.forEach((key, value) {
        paramsString += "&$key=$value";
      });

      String url = "$baseUrl/api/?$paramsString";
      print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = convert.jsonDecode(response.body);
        return PixabayModel<ImageItem>.fromJson(json as Map<String, dynamic>);
      }
      throw Exception("解析错误");
    } catch (error) {
      print("错误:$error");
      return null;
    }
  }

  Future<PixabayModel<VideoItem>> searchVideo({
    String q,
    String lang,
    String id,
    bool popular = true,
    int page,
    int perPage,
  }) async {
    try {
       Map<String, dynamic> params = {
        //"key": key,
        "q": q ?? '',
        //cs, da, de, en, es, fr, id, it, hu, nl, no, pl, pt, ro, sk, fi, sv, tr, vi, th, bg, ru, el, ja, ko, zh
        "lang": lang ?? 'en',
        "id": id ?? '',
        "order": popular ? 'popular' : 'latest',
        'page': page ?? 1,
        'per_page': perPage ?? 20
      };

      String paramsString = "key=$key";
      params.forEach((key, value) {
        paramsString += "&$key=$value";
      });

      String url = "$baseUrl/api/videos/?$paramsString";
      print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = convert.jsonDecode(response.body);
        return PixabayModel<VideoItem>.fromJson(json as Map<String, dynamic>);
      }
      throw Exception("解析错误");
    } catch (error) {
      print("错误:$error");
      return null;
    }
  }
}

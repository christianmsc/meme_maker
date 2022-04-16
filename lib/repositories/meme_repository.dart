import 'package:dio/dio.dart';

class MemeRepository {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://ronreiter-meme-generator.p.rapidapi.com/',
      headers: {
        'X-RapidAPI-Host': 'ronreiter-meme-generator.p.rapidapi.com',
        'X-RapidAPI-Key': '6833b165damshee5f472ae350193p1822a1jsn43bb7f0d8836'
      }));

  Future<List<String>> getImages() async {
    final response =
        await dio.request('images', options: Options(method: 'GET'));
    final list = response.data as List;

    List<String> images = [];
    for (var item in list) {
      images.add(item);
    }

    return images;
  }
}

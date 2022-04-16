import 'package:dio/dio.dart';
import '../shared/config.dart';

class MemeRepository {
  final dio = Dio(BaseOptions(baseUrl: Config.baseUrl, headers: {
    'X-RapidAPI-Host': Config.apiHost,
    'X-RapidAPI-Key': Config.apiKey
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

  Future<String> getImage(image, uppperText, bottomText) async {
    bottomText = bottomText.replaceAll(' ', '+');
    uppperText = uppperText.replaceAll(' ', '+');
    final response = await dio.request(
        'meme?meme=$image&top=$uppperText&bottom=$bottomText',
        options: Options(method: 'GET'));
    return response.data;
  }
}

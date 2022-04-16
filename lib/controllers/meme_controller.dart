import 'package:flutter/widgets.dart';
import 'package:meme_maker/repositories/meme_repository.dart';

import '../enums/request_state_enum.dart';

class MemeController {
  List<String> images = [];
  final memeRepository = MemeRepository();
  final state = ValueNotifier<RequestState>(RequestState.start);

  Future<List<String>> getImages() async {
    state.value = RequestState.loading;
    try {
      if (images.isEmpty) {
        images = await memeRepository.getImages();
      }
    } catch (e) {
      state.value = RequestState.error;
    }
    state.value = RequestState.success;
    return images;
  }
}

import 'package:flutter/widgets.dart';
import 'package:meme_maker/repositories/meme_repository.dart';

import '../enums/request_state_enum.dart';
import '../models/meme_model.dart';

class MemeController {
  List<String> images = [];
  final memeRepository = MemeRepository();
  final state = ValueNotifier<RequestState>(RequestState.start);

  Future<List<String>> getImagesFromApi() async {
    state.value = RequestState.loading;
    try {
      if (images.isEmpty) {
        images = await memeRepository.getImagesFromApi();
      }
    } catch (e) {
      state.value = RequestState.error;
    }
    state.value = RequestState.success;
    return images;
  }

  Future create(MemeModel meme) async {
    return memeRepository.create(meme);
  }

  Future<List<MemeModel>> getAll() async {
    return memeRepository.getAll();
  }

  Future<MemeModel?> getOne(int id) async {
    return memeRepository.getOne(id);
  }

  Future update(MemeModel meme) async {
    return memeRepository.update(meme);
  }

  Future delete(int id) async {
    return memeRepository.delete(id);
  }

  Future deleteAll() async {
    List<MemeModel> memes = await getAll();
    for (var meme in memes) {
      memeRepository.delete(meme.id!);
    }
    return true;
  }
}

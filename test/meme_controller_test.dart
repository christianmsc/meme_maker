import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:meme_maker/controllers/meme_controller.dart';
import 'package:meme_maker/enums/request_state_enum.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

main() {
  test('deve preencher a variavel images', () async {
    // Loading environment variables from a file synchronously.
    dotenv.testLoad(fileInput: File('test/.env').readAsStringSync());
    final memeController = MemeController();
    expect(memeController.state.value, RequestState.start);
    await memeController.getImages();
    expect(memeController.state.value, RequestState.success);
    expect(memeController.images.isNotEmpty, true);
  });
}

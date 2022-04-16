import 'package:flutter_test/flutter_test.dart';
import 'package:meme_maker/controllers/meme_controller.dart';
import 'package:meme_maker/enums/request_state_enum.dart';

main() {
  final memeController = MemeController();

  test('deve preencher a variavel images', () async {
    expect(memeController.state.value, RequestState.start);
    await memeController.getImages();
    expect(memeController.state.value, RequestState.success);
    expect(memeController.images.isNotEmpty, true);
  });
}

import 'package:flutter/material.dart';
import 'package:meme_maker/controllers/meme_controller.dart';
import 'package:meme_maker/models/meme_model.dart';
import 'package:meme_maker/views/meme_form/meme_form.dart';

import '../../components/nav_bar_edit.dart';
import '../../components/nav_bar_no_action.dart';
import '../../enums/request_state_enum.dart';

class MemeFormView extends StatefulWidget {
  const MemeFormView({Key? key}) : super(key: key);

  @override
  State<MemeFormView> createState() => _MemeFormViewState();
}

class _MemeFormViewState extends State<MemeFormView> {
  final String createTitle = 'Criar Meme';
  final String editTitle = 'Editar Meme';
  final memeController = MemeController();
  List<String> images = [];
  MemeModel? meme;

  _start() {
    return Container();
  }

  _success() {
    return MemeForm(memeController, meme);
  }

  _error() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Erro ao carregar os dados =('),
          ElevatedButton(
              onPressed: () async {
                images = await memeController.getImagesFromApi();
              },
              child: const Text('Tentar Novamente'))
        ],
      ),
    );
  }

  _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  stateManagement(RequestState state) {
    switch (state) {
      case RequestState.start:
        return _start();
      case RequestState.loading:
        return _loading();
      case RequestState.success:
        return _success();
      case RequestState.error:
        return _error();
      default:
        return _start();
    }
  }

  void _getImages() async {
    images = await memeController.getImagesFromApi();
  }

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  @override
  Widget build(BuildContext context) {
    meme = ModalRoute.of(context)!.settings.arguments != null ? ModalRoute.of(context)!.settings.arguments as MemeModel : null;
    return Scaffold(
        appBar: meme != null ? NavBarEdit(title: editTitle, meme: meme!, memeController: memeController).build(context) : NavBarNoAction(title: createTitle).build(context),
        body: AnimatedBuilder(
          animation: memeController.state,
          builder: (context, child) {
            return stateManagement(memeController.state.value);
          },
        ));
  }
}

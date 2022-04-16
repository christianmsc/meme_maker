import 'package:flutter/material.dart';
import 'package:meme_maker/controllers/meme_controller.dart';
import 'package:meme_maker/views/meme_form/meme_form.dart';

import '../../components/nav_bar_back.dart';
import '../../enums/request_state_enum.dart';

class MemeFormView extends StatefulWidget {
  const MemeFormView({Key? key}) : super(key: key);

  @override
  State<MemeFormView> createState() => _MemeFormViewState();
}

class _MemeFormViewState extends State<MemeFormView> {
  final String title = 'Criar Meme';
  final memeController = MemeController();
  List<String> images = [];

  _start() {
    return Container();
  }

  _success() {
    return MemeForm(images);
  }

  _error() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Erro ao carregar os dados =('),
          ElevatedButton(
              onPressed: () async {
                images = await memeController.getImages();
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
    images = await memeController.getImages();
  }

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
            appBar: NavBarBack(title: title).build(context),
            body: AnimatedBuilder(
              animation: memeController.state,
              builder: (context, child) {
                return stateManagement(memeController.state.value);
              },
            )));
  }
}

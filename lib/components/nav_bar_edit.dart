import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:meme_maker/controllers/meme_controller.dart';
import 'package:meme_maker/models/meme_model.dart';

import '../shared/config.dart';

class NavBarEdit extends StatelessWidget {
  final String title;
  final MemeModel meme;
  final MemeController memeController;
  const NavBarEdit(
      {Key? key,
      required this.title,
      required this.meme,
      required this.memeController})
      : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
            onPressed: () async {
              try {
                await ImageDownloader.downloadImage(
                    Config.basePublicUrl + meme.toUrl());
                Fluttertoast.showToast(
                    msg: "Meme baixado!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } catch (e) {
                Fluttertoast.showToast(
                    msg: "Erro ao baixar meme =(",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            icon: const Icon(Icons.download, color: Colors.white),
            tooltip: 'Baixar meme'),
        IconButton(
            onPressed: () async {
              await memeController.delete(meme.id!);
              Fluttertoast.showToast(
                  msg: "Meme excluido!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete, color: Colors.white),
            tooltip: 'Excluir meme')
      ],
    );
  }
}

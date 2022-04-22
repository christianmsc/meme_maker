import 'package:flutter/material.dart';
import 'package:meme_maker/models/meme_model.dart';

import '../../controllers/meme_controller.dart';
import '../../shared/config.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<String>> photos;
  late Future<List<MemeModel>> memes;
  final memeController = MemeController();

  Future<List<MemeModel>> _getMemes() async {
    var memes = await memeController.getAll();
    return memes;
  }

  @override
  void initState() {
    super.initState();
    memes = _getMemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/meme-form')
                      .then((_) => setState(() => {memes = _getMemes()}));
                },
                icon: const Icon(Icons.add, color: Colors.white),
                tooltip: 'Novo meme')
          ],
        ),
        body: FutureBuilder<List<MemeModel>>(
          future: memes,
          initialData: const [],
          builder: (
            BuildContext context,
            AsyncSnapshot<List<MemeModel>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [CircularProgressIndicator()],
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError || !snapshot.hasData) {
                return const Text('Error');
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(snapshot.data!.length, (index) {
                    return InkResponse(
                      onTap: () => Navigator.pushNamed(context, '/meme-form',
                              arguments: snapshot.data![index])
                          .then((_) => setState(() => {memes = _getMemes()})),
                      child: Center(
                          child: SizedBox(
                              width: 180,
                              height: 180,
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: FittedBox(
                                    child: Image(
                                        image: NetworkImage(
                                            Config.basePublicUrl +
                                                snapshot.data![index].toUrl())),
                                    fit: BoxFit.fill,
                                  )))),
                    );
                  }),
                );
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text('Nenhum meme criado =(',
                                style: TextStyle(fontSize: 21))
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/meme-form')
                                      .then((_) => setState(
                                          () => {memes = _getMemes()}));
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red)),
                                child: const Text('Criar Meme',
                                    style: TextStyle(color: Colors.white)))
                          ])
                    ]);
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ));
  }
}

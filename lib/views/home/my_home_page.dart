import 'package:flutter/material.dart';
import 'package:meme_maker/components/nav_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> photos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar(title: widget.title).build(context), body: buildScreen(context));
  }

  buildScreen(context) {
    setState(() {
      photos = [];
      // photos = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
    });
    if (photos.isEmpty) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text('Nenhum meme criado =(', style: TextStyle(fontSize: 21))
            ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/meme-form');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              child: const Text('Criar Meme',
                  style: TextStyle(color: Colors.white)))
        ])
      ]);
    } else {
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(photos.length, (index) {
          return Center(
            child: Text(
              photos[index],
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }),
      );
    }
  }
}

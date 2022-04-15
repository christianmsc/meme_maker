import 'package:flutter/material.dart';

import '../meme_form/meme_form.dart';
import 'my_home_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meme Maker',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(title: 'Meus Memes'),
          '/meme-form': (context) => const MemeForm()
        });
  }
}

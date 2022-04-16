import 'package:flutter/material.dart';

import '../meme_form/meme_form_view.dart';
import 'my_home_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
          '/meme-form': (context) => const MemeFormView()
        });
  }
}

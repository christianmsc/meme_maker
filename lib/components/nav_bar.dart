import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final String title;

  const NavBar({Key? key, required this.title}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/meme-form');
            },
            icon: const Icon(Icons.add, color: Colors.white),
            tooltip: 'Novo meme')
      ],
    );
  }
}

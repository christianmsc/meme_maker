import 'package:flutter/material.dart';

class NavBarNoAction extends StatelessWidget {
  final String title;

  const NavBarNoAction({Key? key, required this.title}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(title)
    );
  }
}

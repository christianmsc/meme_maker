import 'package:flutter/material.dart';

class NavBarBack extends StatelessWidget {
  final String title;

  const NavBarBack({Key? key, required this.title}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}

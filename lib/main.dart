import 'package:flutter/material.dart';
import 'package:meme_maker/views/home/home_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const HomeView());
}

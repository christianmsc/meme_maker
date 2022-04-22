import 'package:dio/dio.dart';
import 'package:meme_maker/models/meme_model.dart';
import '../shared/config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MemeRepository {
  final DATABASE_NAME = 'meme.db';
  final TABLE_NAME = 'memes';
  final dio = Dio(BaseOptions(baseUrl: Config.baseUrl, headers: {
    'X-RapidAPI-Host': Config.apiHost,
    'X-RapidAPI-Key': Config.apiKey
  }));

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE memes(id INTEGER PRIMARY KEY, image TEXT, upperText TEXT, bottomText TEXT)');
      },
      version: 1,
    );
  }

  Future create(MemeModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.insert(
        TABLE_NAME,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<MemeModel>> getAll() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

      return List.generate(
        maps.length,
        (i) {
          return MemeModel(
            maps[i]['id'],
            maps[i]['image'],
            maps[i]['upperText'],
            maps[i]['bottomText'],
          );
        },
      );
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<MemeModel?> getOne(int id) async {
    try {
      final Database db = await _getDatabase();
      var result = await db.query(TABLE_NAME, where: "id = ", whereArgs: [id]);
      if (result.isNotEmpty) {
        var meme = MemeModel(int.parse(result.first['id'].toString()), result.first['image'].toString(), result.first['upperText'].toString(), result.first['bottomText'].toString());
        return meme;
      }
      else {
        throw 'Not found';
      }
    } catch (ex) {
      return null;
    }
  }

  Future update(MemeModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.update(
        TABLE_NAME,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future delete(int id) async {
    try {
      final Database db = await _getDatabase();
      await db.delete(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  // call to api
  Future<List<String>> getImagesFromApi() async {
    final response =
        await dio.request('images', options: Options(method: 'GET'));
    final list = response.data as List;

    List<String> images = [];
    for (var item in list) {
      images.add(item);
    }

    return images;
  }
}

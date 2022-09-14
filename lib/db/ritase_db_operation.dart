import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class RitaseDBOperation {
  Future<void> insertRitases(List<dynamic> ritases) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'ritase.db'),
      version: 1,
    );

    final db = await database;

    Batch batch = db.batch();

    for (var e in ritases) {
      batch.insert(
        'ritases',
        e.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);

    // await db.insert(
    //   'units',
    //   unit.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }

  Future<void> deleteAllRitases() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'ritase.db'),
      version: 1,
    );
    final db = await database;

    await db.delete('ritases');
  }
}

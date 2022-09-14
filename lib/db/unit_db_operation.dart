import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class UnitDBOperation {
  Future<void> insertUnits(List<dynamic> units) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'ritase.db'),
      version: 1,
    );

    final db = await database;

    Batch batch = db.batch();

    for (var e in units) {
      batch.insert(
        'units',
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

  Future<void> deleteAllUnits() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'ritase.db'),
      version: 1,
    );
    final db = await database;

    await db.delete('units');
  }
}

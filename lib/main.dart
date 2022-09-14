import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ritase/cubit/page_cubit.dart';
import 'package:ritase/cubit/ritase_cubit.dart';
import 'package:ritase/cubit/unit_cubit.dart';
import 'package:ritase/ui/pages/home_page.dart';
import 'package:ritase/ui/pages/splash_page.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  openDatabase(
    join(await getDatabasesPath(), 'ritase.db'),
    onCreate: (db, version) => _createDb(db),
    version: 1,
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

void _createDb(Database db) {
  db.execute(
    'CREATE TABLE units(unit_kode INTEGER PRIMARY KEY,name TEXT, operator TEXT)',
  );
  db.execute(
    'CREATE TABLE ritases(ritase_id INTEGER PRIMARY KEY,ritase_date TEXT, ritase_time TEXT, ritase_material TEXT, ritase_kategori TEXT, ritase_keterangan TEXT, kode_unit INTEGER)',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UnitCubit(),
        ),
        BlocProvider(
          create: (context) => RitaseCubit(),
        ),
        BlocProvider(
          create: (context) => PageCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_database/data/expense_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'maintask.dart';
import 'model/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DataAdapter());
  await Hive.openBox('data_box');
  Hive.registerAdapter(Data3Adapter());
  await Hive.openBox('data_expense');
  await Hive.openBox('expense_database');
  await Hive.openBox('cash');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        debugShowCheckedModeBanner: false,
        home: const MainTask(),
      ),
    );
  }
}

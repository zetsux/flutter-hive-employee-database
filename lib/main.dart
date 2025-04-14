import 'package:flutter/material.dart';
import 'package:flutter_hive_assignment/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialize Hive
  await Hive.initFlutter();

  // open Box
  await Hive.openBox('employee_box');
  await Hive.openBox('employee_id');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

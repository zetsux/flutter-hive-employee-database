import 'package:flutter/material.dart';
import 'package:flutter_hive_assignment/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialize Hive
  await Hive.initFlutter();

  // open Box
  await Hive.openBox('student_box');
  await Hive.openBox('student_id');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

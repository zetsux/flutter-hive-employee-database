import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dbBox = Hive.box("db_box");

  void writeData() {
    final user = {'name': 'Beta', 'hobby': 'Swimming', 'age': 17};
    _dbBox.put(1, user);
  }

  void readData() {
    print(_dbBox.values);
  }

  void deleteData() {
    _dbBox.delete(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: writeData,
              color: Colors.blue,
              child: Text("Write"),
            ),
            MaterialButton(
              onPressed: readData,
              color: Colors.green,
              child: Text("Read"),
            ),
            MaterialButton(
              onPressed: deleteData,
              color: Colors.red,
              child: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}

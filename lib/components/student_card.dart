import 'package:flutter/material.dart';
import 'package:flutter_hive_assignment/model/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback delete;
  final VoidCallback edit;

  // Use required parameters
  StudentCard({
    required this.student,
    required this.delete,
    required this.edit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(student.name, style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 6.0),
            Text(
              student.number,
              style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: edit,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: delete,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

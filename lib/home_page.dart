import 'package:flutter/material.dart';
import 'package:flutter_hive_assignment/components/student_card.dart';
import 'package:flutter_hive_assignment/model/student.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _studentBox = Hive.box("student_box");
  final _idBox = Hive.box("student_id");

  void saveStudent(Student student) {
    var studentID = _idBox.get('student_id');
    if (studentID == null) {
      studentID = 1;
      _idBox.put('student_id', studentID);
    } else {
      studentID++;
    }

    final newStudent = {
      'id': studentID,
      'name': student.name,
      'number': student.number,
      'email': student.email,
      'phone': student.phone,
      'birth_date': student.birthDate,
      'grades': student.grades,
    };
    _studentBox.put(studentID, newStudent);
    _idBox.put('student_id', studentID);
  }

  void updateStudent(Student student, int studentID) {
    if (studentID != 0) {
      final newStudent = {
        'id': studentID,
        'name': student.name,
        'number': student.number,
        'email': student.email,
        'phone': student.phone,
        'birth_date': student.birthDate,
        'grades': student.grades,
      };
      _studentBox.put(studentID, newStudent);
    }
  }

  void deleteStudent(int id) {
    _studentBox.delete(id);
  }

  void _addStudent() {
    final newStudent = Student(
      name: "",
      number: "",
      email: "",
      phone: "",
      birthDate: "",
      grades: {},
    );
    _editStudent(newStudent, isNew: true);
  }

  void clearStudent() {
    _studentBox.clear();
  }

  void _editStudent(Student student, {bool isNew = false, int studentID = 0}) {
    TextEditingController nameController = TextEditingController(
      text: student.name,
    );
    TextEditingController numberController = TextEditingController(
      text: student.number,
    );
    TextEditingController emailController = TextEditingController(
      text: student.email,
    );
    TextEditingController phoneController = TextEditingController(
      text: student.phone,
    );
    TextEditingController birthDateController = TextEditingController(
      text: student.birthDate,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isNew ? "Add Student" : "Edit Student"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: "Student Number"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: birthDateController,
                decoration: const InputDecoration(labelText: "Birth Date"),
                readOnly: true,
                onTap: () async {
                  DateTime initialDate;

                  try {
                    initialDate = DateFormat(
                      'yyyy-MM-dd',
                    ).parse(birthDateController.text);
                  } catch (e) {
                    initialDate = DateTime.now();
                  }

                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    birthDateController.text = DateFormat(
                      'yyyy-MM-dd',
                    ).format(pickedDate);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  student.name = nameController.text;
                  student.number = numberController.text;
                  student.email = emailController.text;
                  student.phone = phoneController.text;
                  student.birthDate = birthDateController.text;

                  if (isNew) {
                    saveStudent(student);
                  } else {
                    updateStudent(student, studentID);
                  }
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _studentBox.listenable(),
        builder: (context, Box studentBox, _) {
          final students = studentBox.values.toList();

          return ListView(
            children:
                students.map((st) {
                  final student = Student(
                    name: st["name"] ?? "",
                    number: st["number"] ?? "",
                    email: st["email"] ?? "",
                    phone: st["phone"] ?? "",
                    birthDate: st["birth_date"] ?? "",
                    grades: st["grades"] ?? "",
                  );

                  return StudentCard(
                    student: student,
                    edit: () => _editStudent(student, studentID: st["id"]),
                    delete: () => deleteStudent(st["id"]),
                  );
                }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStudent,
        child: Icon(Icons.add),
      ),
    );
  }
}

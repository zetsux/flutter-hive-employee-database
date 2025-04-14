import 'package:flutter/material.dart';
import 'package:flutter_hive_assignment/components/employee_card.dart';
import 'package:flutter_hive_assignment/detail_page.dart';
import 'package:flutter_hive_assignment/model/employee.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _employeeBox = Hive.box("employee_box");
  final _idBox = Hive.box("employee_id");

  void saveEmployee(Employee employee) {
    var employeeID = _idBox.get('employee_id');
    if (employeeID == null) {
      employeeID = 1;
      _idBox.put('employee_id', employeeID);
    } else {
      employeeID++;
    }

    final newEmployee = {
      'id': employeeID,
      'name': employee.name,
      'number': employee.number,
      'position': employee.position,
      'email': employee.email,
      'phone': employee.phone,
      'address': employee.address,
      'birth_date': employee.birthDate,
      'wage': employee.wage,
      'note': employee.note,
    };
    _employeeBox.put(employeeID, newEmployee);
    _idBox.put('employee_id', employeeID);
  }

  void deleteEmployee(int id) {
    _employeeBox.delete(id);
  }

  void _addEmployee() {
    final newEmployee = Employee(
      name: "",
      number: "",
      position: "",
      email: "",
      phone: "",
      address: "",
      birthDate: "",
      wage: "",
      note: "",
    );
    _fillEmployeeInformation(newEmployee);
  }

  void _fillEmployeeInformation(Employee employee) {
    TextEditingController nameController = TextEditingController(
      text: employee.name,
    );
    TextEditingController numberController = TextEditingController(
      text: employee.number,
    );
    TextEditingController positionController = TextEditingController(
      text: employee.position,
    );
    TextEditingController emailController = TextEditingController(
      text: employee.email,
    );
    TextEditingController phoneController = TextEditingController(
      text: employee.phone,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Employee"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: "Employee Number"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: positionController,
                decoration: const InputDecoration(labelText: "Position"),
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
                  employee.name = nameController.text;
                  employee.number = numberController.text;
                  employee.position = positionController.text;
                  employee.email = emailController.text;
                  employee.phone = phoneController.text;

                  saveEmployee(employee);
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Material(
          elevation: 8,
          shadowColor: Colors.black38,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            centerTitle: true,
            title: Text(
              "Employee Database",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),

      body: ValueListenableBuilder(
        valueListenable: _employeeBox.listenable(),
        builder: (context, Box employeeBox, _) {
          final employees = employeeBox.values.toList();

          return ListView(
            children:
                employees.map((st) {
                  final employee = Employee(
                    name: st["name"] ?? "",
                    number: st["number"] ?? "",
                    position: st["position"] ?? "",
                    email: st["email"] ?? "",
                    phone: st["phone"] ?? "",
                    address: st["address"] ?? "",
                    birthDate: st["birth_date"] ?? "",
                    wage: st["wage"] ?? "",
                    note: st["note"] ?? "",
                  );

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => DetailPage(
                                employee: employee,
                                employeeID: st["id"],
                                employeeBox: employeeBox,
                                delete: () => deleteEmployee(st["id"]),
                              ),
                        ),
                      );
                    },
                    child: EmployeeCard(employee: employee),
                  );
                }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEmployee,
        child: Icon(Icons.add),
      ),
    );
  }
}

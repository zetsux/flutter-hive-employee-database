import 'package:flutter/material.dart';
import 'package:flutter_hive_assignment/model/employee.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final Employee employee;
  final dynamic employeeID;
  final Box<dynamic> employeeBox;
  final VoidCallback delete;

  const DetailPage({
    super.key,
    required this.employee,
    required this.employeeID,
    required this.employeeBox,
    required this.delete,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController positionController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController birthDateController;
  late TextEditingController wageController;
  late TextEditingController noteController;

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.employee.name);
    numberController = TextEditingController(text: widget.employee.number);
    positionController = TextEditingController(text: widget.employee.position);
    emailController = TextEditingController(text: widget.employee.email);
    phoneController = TextEditingController(text: widget.employee.phone);
    addressController = TextEditingController(text: widget.employee.address);
    birthDateController = TextEditingController(
      text: widget.employee.birthDate,
    );
    wageController = TextEditingController(text: widget.employee.wage);
    noteController = TextEditingController(text: widget.employee.note);
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() => isEditing = !isEditing);
  }

  void _saveChanges() async {
    final updatedEmployee = Employee(
      name: nameController.text,
      number: numberController.text,
      position: positionController.text,
      email: emailController.text,
      phone: phoneController.text,
      address: addressController.text,
      birthDate: birthDateController.text,
      wage: wageController.text,
      note: noteController.text,
    );

    widget.employeeBox.put(widget.employeeID, {
      'id': widget.employeeID,
      'name': updatedEmployee.name,
      'number': updatedEmployee.number,
      'position': updatedEmployee.position,
      'email': updatedEmployee.email,
      'phone': updatedEmployee.phone,
      'address': updatedEmployee.address,
      'birth_date': updatedEmployee.birthDate,
      'wage': updatedEmployee.wage,
      'note': updatedEmployee.note,
    });

    setState(() => isEditing = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Changes saved")));
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    TextInputType type,
  ) {
    if (!isEditing) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4),
            Text(
              controller.text.isNotEmpty ? controller.text : '-',
              style: TextStyle(fontSize: 16),
            ),
            Divider(color: Colors.transparent),
          ],
        ),
      );
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: type,
    );
  }

  Widget _buildDateTimeTextField(
    String label,
    TextEditingController controller,
  ) {
    if (!isEditing) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4),
            Text(
              controller.text.isNotEmpty ? controller.text : '-',
              style: TextStyle(fontSize: 16),
            ),
            Divider(color: Colors.transparent),
          ],
        ),
      );
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      readOnly: true,
      onTap: () async {
        DateTime initialDate;

        try {
          initialDate = DateFormat('yyyy-MM-dd').parse(controller.text);
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
          controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Employee" : "Employee Details"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (isEditing) {
                _saveChanges();
              } else {
                _toggleEdit();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField("Name", nameController, TextInputType.name),
            _buildTextField(
              "Employee Number",
              numberController,
              TextInputType.number,
            ),
            _buildTextField("Position", positionController, TextInputType.text),
            _buildTextField(
              "Email",
              emailController,
              TextInputType.emailAddress,
            ),
            _buildTextField(
              "Phone Number",
              phoneController,
              TextInputType.phone,
            ),
            _buildTextField(
              "Address",
              addressController,
              TextInputType.streetAddress,
            ),
            _buildDateTimeTextField("Birth Date", birthDateController),
            _buildTextField(
              "Monthly Wage",
              wageController,
              TextInputType.number,
            ),
            _buildTextField("Note", noteController, TextInputType.multiline),
          ],
        ),
      ),
    );
  }
}

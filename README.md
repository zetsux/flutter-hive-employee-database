# flutter_hive_assignment

## Description

This is an Employee Database application project with the main goal of learning **Hive**, which is a lightweight and fast key-value (NoSQL) database written in pure Dart. It's a perfect fit for a Flutter app that needs a lightweight datastore with higher performance compared to other existing alternatives like _SQLite_ or _SharedPreferences_.

## Programming Steps

1. Open the `pubspec.yaml` file and add the necessary dependencies for Hive, as follows,

```yaml
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  hive_generator: ^1.1.3
```

2. Save the dependencies and import the `hive_flutter` package by writing the following lines,

```dart
import 'package:hive_flutter/hive_flutter.dart';
```

3. Initiate Hive for Flutter by calling `initFlutter()` function

```dart
await Hive.initFlutter();
```

4. Open a box using the `openBox()` function with the box name as the sole parameter in String type

```dart
await Hive.openBox(<nama_box>);
```

5. Access the box by initializing a final-typed variable using the `box()` function with the box name as the sole parameter in String type, as follows,

```dart
final _dbBox = Hive.box(<nama_box>);
```

6. Then, we'll be able to utilize the box for ordinary database / datastore features such like CRUD, these following lines are some examples of them,

```dart
void saveEmployee(Employee employee) {
  // mimicking the behaviour of auto-increment
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
```

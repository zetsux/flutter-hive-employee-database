import 'package:flutter/material.dart';
import 'package:flutter_hive_assignment/model/employee.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final iconColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  employee.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                Icon(Icons.search, size: 22, color: iconColor),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.badge_outlined, size: 18, color: iconColor),
                const SizedBox(width: 6),
                Text(
                  "${employee.number} / ${employee.position}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.email_outlined, size: 18, color: iconColor),
                const SizedBox(width: 6),
                Text(
                  employee.email,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.phone, size: 18, color: iconColor),
                const SizedBox(width: 6),
                Text(
                  employee.phone,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: textColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

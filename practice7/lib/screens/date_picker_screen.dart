import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DatePickerScreen extends StatelessWidget {
  const DatePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Виберіть дату повернення')),
      body: CalendarDatePicker(
        initialDate: DateTime.now().add(const Duration(days: 7)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        onDateChanged: (date) {
          context.pop(date);
        },
      ),
    );
  }
}
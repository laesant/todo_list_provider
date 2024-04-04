import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(foregroundColor: Colors.grey),
        onPressed: () async {
          final DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: context.read<TaskCreateController>().selectedDate,
            firstDate: DateTime(2020),
            lastDate: DateTime.now().add(const Duration(days: 5 * 365)),
          );
          if (context.mounted) {
            context.read<TaskCreateController>().selectedDate = selectedDate;
          }
        },
        icon: const Icon(Icons.calendar_month),
        label: Selector<TaskCreateController, String?>(
          selector: (_, controller) {
            if (controller.selectedDate == null) {
              return null;
            }
            return DateFormat('dd/MM/yyyy').format(controller.selectedDate!);
          },
          builder: (_, value, __) {
            return Text(value ?? 'SELECIONE UMA DATA');
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  const Task({super.key, required this.task});
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.grey)]),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1)),
          leading: Checkbox(
              onChanged: (_) {
                context.read<HomeController>().checkOrUnchenckTask(task);
              },
              value: task.finished),
          title: Text(
            task.description,
            style: TextStyle(
                decoration: task.finished ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(
            DateFormat('dd/MM/yyyy').format(task.dateTime),
            style: TextStyle(
                decoration: task.finished ? TextDecoration.lineThrough : null),
          ),
        ),
      ),
    );
  }
}

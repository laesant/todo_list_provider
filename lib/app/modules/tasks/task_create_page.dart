import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/widgets/calendar_button.dart';

class TaskCreatePage extends StatelessWidget {
  const TaskCreatePage({super.key, required TaskCreateController controller})
      : _controller = controller;
  final TaskCreateController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text(
          'Salvar Tarefa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Criar Nova Tarefa',
                  style: context.titleStyle.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(height: 30),
              TodoListField(label: ''),
              const SizedBox(height: 20),
              const CalendarButton()
            ],
          ),
        ),
      ),
    );
  }
}

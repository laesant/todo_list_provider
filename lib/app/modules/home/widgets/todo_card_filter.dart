import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';

class TodoCardFilter extends StatelessWidget {
  const TodoCardFilter(
      {super.key,
      required this.label,
      required this.taskFilter,
      this.totalTasksModel,
      required this.selected});
  final String label;
  final TaskFilter taskFilter;
  final TotalTasksModel? totalTasksModel;
  final bool selected;
  double _getPercentFinished() {
    final total = totalTasksModel?.totalTasks ?? 0.0;
    final totalFinished = totalTasksModel?.totalTasksFinished ?? 0.0;

    if (total == 0) {
      return 0;
    }

    return ((totalFinished * 100) / total) / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(width: 1, color: Colors.grey.withOpacity(.8)),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${totalTasksModel?.totalTasks ?? 0} TAREFAS',
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: selected ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: _getPercentFinished()),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                backgroundColor:
                    selected ? context.primaryContainerColor : Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(
                    selected ? Colors.white : context.primaryColor),
                value: value,
              );
            },
          )
        ],
      ),
    );
  }
}

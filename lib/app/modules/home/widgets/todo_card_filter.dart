import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class TodoCardFilter extends StatefulWidget {
  const TodoCardFilter({super.key});

  @override
  State<TodoCardFilter> createState() => _TodoCardFilterState();
}

class _TodoCardFilterState extends State<TodoCardFilter> {
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
          color: context.primaryColor,
          border: Border.all(width: 1, color: Colors.grey.withOpacity(.8)),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '10 TAREFAS',
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'HOJE',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            backgroundColor: context.primaryContainerColor,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
            value: 0,
          )
        ],
      ),
    );
  }
}

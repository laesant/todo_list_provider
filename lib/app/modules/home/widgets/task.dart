import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({super.key});

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
          leading: Checkbox(onChanged: (value) {}, value: true),
          title: Text(
            'Descrição da Tarefa',
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          subtitle: Text(
            '27/04/2024',
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
        ),
      ),
    );
  }
}

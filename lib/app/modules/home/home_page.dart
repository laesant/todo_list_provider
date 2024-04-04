import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_header.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFE),
      appBar: AppBar(
        foregroundColor: context.primaryColor,
        actions: [
          PopupMenuButton(
            tooltip: 'Mostrar menu',
            icon: const Icon(Icons.filter_alt),
            itemBuilder: (_) => [
              const PopupMenuItem<bool>(
                  child: Text('Mostrar tarefas concluidas'))
            ],
          )
        ],
      ),
      drawer: const HomeDrawer(),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(),
                  HomeFilters(),
                  HomeWeekFilter(),
                  HomeTasks(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

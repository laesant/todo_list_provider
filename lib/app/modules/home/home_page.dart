import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_header.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_module.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required HomeController homeController})
      : _homeController = homeController;
  final HomeController _homeController;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget._homeController.implementDefaultListenerNotifier(
        context: context, onSuccess: (notifier) {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._homeController.loadTotalTasks();
      widget._homeController.findTasks(filter: TaskFilter.today);
    });
  }

  Future<void> _goToCreateTask(BuildContext context) async {
    //  Navigator.of(context).pushNamed('/task/create');
    await Navigator.of(context).push(PageRouteBuilder(
      fullscreenDialog: true,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation =
            CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
        return ScaleTransition(
          scale: animation,
          alignment: Alignment.bottomRight,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return TasksModule().getPage('/task/create', context);
      },
    ));
    widget._homeController.refreshPage();
  }

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
            onSelected: (_) {
              widget._homeController.showOrHideFinishedTasks();
            },
            itemBuilder: (_) => [
              PopupMenuItem<bool>(
                  value: true,
                  child: Text(
                      '${widget._homeController.showFinishedTasks ? " Esconder" : "Mostrar"} tarefas concluidas'))
            ],
          )
        ],
      ),
      drawer: const HomeDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToCreateTask(context),
        child: const Icon(Icons.add),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: const IntrinsicHeight(
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

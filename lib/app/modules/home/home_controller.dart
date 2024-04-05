import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/services/task/task_service.dart';

class HomeController extends DefaultChangeNotifier {
  HomeController({required TaskService taskService})
      : _taskService = taskService;

  final TaskService _taskService;
  var selectedFilter = TaskFilter.today;
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _taskService.getToday(),
      _taskService.getTomorrow(),
      _taskService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    todayTotalTasks = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTasksFinished: todayTasks.where((task) => task.finished).length,
    );

    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinished: tomorrowTasks.where((task) => task.finished).length,
    );

    final weekTasks = allTasks[2] as WeekTaskModel;
    weekTotalTasks = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinished: weekTasks.tasks.where((task) => task.finished).length,
    );

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilter filter}) async {
    selectedFilter = filter;
    showLoading();
    notifyListeners();
    List<TaskModel>? tasks;

    switch (filter) {
      case TaskFilter.today:
        tasks = await _taskService.getToday();
        break;
      case TaskFilter.tomorrow:
        tasks = await _taskService.getTomorrow();
        break;
      case TaskFilter.week:
        final weekModel = await _taskService.getWeek();
        initialDateOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }
    allTasks = tasks;
    filteredTasks = tasks;

    if (filter == TaskFilter.week && initialDateOfWeek != null) {
      filterByDay(initialDateOfWeek!);
    }

    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks = allTasks.where((task) => task.dateTime == date).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: selectedFilter);
    await loadTotalTasks();
    notifyListeners();
  }
}

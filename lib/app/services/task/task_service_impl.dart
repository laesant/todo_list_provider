import 'package:todo_list_provider/app/repositories/task/task_repository.dart';

import './task_service.dart';

class TaskServiceImpl implements TaskService {
  final TaskRepository _taskRepository;

  TaskServiceImpl({required TaskRepository taskRepository})
      : _taskRepository = taskRepository;

  @override
  Future<void> save(DateTime date, String description) =>
      _taskRepository.save(date, description);
}

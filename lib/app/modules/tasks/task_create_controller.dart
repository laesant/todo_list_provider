import 'package:flutter/foundation.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/task/task_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TaskService _taskService;
  DateTime? _selectedDate;

  TaskCreateController({
    required TaskService taskService,
  }) : _taskService = taskService;

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    if (selectedDate != _selectedDate) {
      _selectedDate = selectedDate;
      notifyListeners();
    }
  }

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _taskService.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da tarefa não selecionada');
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      setError('Erro ao cadastrar tarefa');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}

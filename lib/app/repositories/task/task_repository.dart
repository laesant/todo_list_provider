abstract interface class TaskRepository {
Future<void> save(DateTime date, String description);
}
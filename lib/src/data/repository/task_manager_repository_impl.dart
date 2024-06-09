import '../../src.dart';

class TaskManagerRepositoryImpl extends TaskManagerRepository {
  final TasksLocalStorage _tasksLocalStorage;

  TaskManagerRepositoryImpl({
    required TasksLocalStorage localStorage,
  }) : _tasksLocalStorage = localStorage;


  @override
  Future<List<Task>> getSavedTasks() async {
    final savedTasks = _tasksLocalStorage.fetchTasks();
    return savedTasks;
  }

  @override
  Future<void> saveTask(List<Task> task) async {
    _tasksLocalStorage.saveTasks(task: task);
  }
}

import '../../src.dart';

abstract class TaskManagerRepository {
  Future<List<Task>> getSavedTasks();

  Future<void> saveTask(List<Task> task);


}



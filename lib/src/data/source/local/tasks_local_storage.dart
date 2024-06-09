import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../src.dart';

abstract class TasksLocalStorage {
  Future<void> saveTasks({
    required List<Task> task,
  });

  Future<List<Task>> fetchTasks();

}

class TasksLocalStorageImpl implements TasksLocalStorage {
  @override
  Future<List<Task>> fetchTasks() async {
    final sharedPref = await SharedPreferences.getInstance();
    final tasksString = sharedPref.getString(Constants.fetchTasksKey);

    if (tasksString != null) {
      final List<dynamic> tasksJson = json.decode(tasksString);
      return tasksJson.map((json) => Task.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> saveTasks({required List<Task> task}) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = task.map((task) => task.toJson()).toList();
    prefs.setString(Constants.fetchTasksKey, json.encode(tasksJson));

    return;
  }
}

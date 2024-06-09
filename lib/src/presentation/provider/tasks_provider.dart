import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../src.dart';

final taskRepositoryProvider = Provider<TaskManagerRepository>((ref) {
  return TaskManagerRepositoryImpl(
    localStorage: TasksLocalStorageImpl(),
  );
});

final getTasksProvider = Provider<GetTasks>((ref) {
  return GetTasks(ref.read(taskRepositoryProvider));
});

final addTaskProvider = Provider<AddTask>((ref) {
  return AddTask(ref.read(taskRepositoryProvider));
});

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier(ref);
});

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier(this.ref) : super([]) {
    _loadTasks();
  }

  final Ref ref;

  Future<void> _loadTasks() async {
    state = await ref.read(getTasksProvider).call();
  }

  Future<void> addTask(Task task) async {
    state = [...state, task];
    await ref.read(addTaskProvider).call(state);
    _loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    state = state.where((tasks) => tasks.taskId != task.taskId).toList();

    await ref.read(addTaskProvider).call(state);
    _loadTasks();
  }
}

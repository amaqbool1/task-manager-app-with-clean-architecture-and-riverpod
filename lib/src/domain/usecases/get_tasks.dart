import '../../src.dart';

class GetTasks {
  final TaskManagerRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.getSavedTasks();
  }
}

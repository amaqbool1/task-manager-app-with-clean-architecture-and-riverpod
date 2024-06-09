import '../../src.dart';

class AddTask {
  final TaskManagerRepository repository;

  AddTask(this.repository);

  Future<void> call(List<Task> task) async {
    return await repository.saveTask(task);
  }
}

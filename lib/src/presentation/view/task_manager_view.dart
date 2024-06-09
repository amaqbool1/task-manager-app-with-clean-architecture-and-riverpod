import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../src.dart';
import 'package:uuid/uuid.dart';

class TaskManagerView extends ConsumerWidget {
  const TaskManagerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    debugPrint("Tasks List >> $tasks");
    return Scaffold(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Task Manager"),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: Colors.white,
                visualDensity: VisualDensity.comfortable,
                style: ListTileStyle.list,
                titleAlignment: ListTileTitleAlignment.center,
                leading: const Icon(
                  Icons.task_alt,
                  color: Colors.green,
                ),
                title: Text(
                  tasks[index].taskTitle ?? "",
                ),
                subtitle: Text(
                  tasks[index].taskDescription ?? "",
                ),
                trailing: IconButton(
                  onPressed: () {
                    ref.read(tasksProvider.notifier).deleteTask(tasks[index]);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: tasks.length,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewTask(context, ref);
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

void _addNewTask(BuildContext context, WidgetRef ref) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Create Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Title is required!",
                    ),
                  ),
                );
                return;
              }

              if (descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Description is required!",
                    ),
                  ),
                );
                return;
              }

              final id = const Uuid().v4();
              final newTask = Task(
                taskId: id,
                taskTitle: titleController.text,
                taskDescription: descriptionController.text,
              );

              ref.read(tasksProvider.notifier).addTask(newTask);

              Navigator.of(context).pop();
            },
            child: const Text('Create'),
          ),
        ],
      );
    },
  );
}

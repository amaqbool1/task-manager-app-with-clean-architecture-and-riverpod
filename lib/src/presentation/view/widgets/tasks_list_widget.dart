import 'package:flutter/material.dart';

import '../../../src.dart';

class TasksListWidget extends StatelessWidget {
  final List<Task> tasksList;

  const TasksListWidget({
    super.key,
    required this.tasksList,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                tasksList[index].taskTitle ?? "",
              ),
              subtitle: Text(
                tasksList[index].taskDescription ?? "",
              ),
              trailing: IconButton(
                onPressed: () {},
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
          itemCount: tasksList.length,
        )
      ],
    );
  }
}

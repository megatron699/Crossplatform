import 'package:flutter/material.dart';
import 'package:todo_list/TaskModel.dart';
typedef ToggleTodoCallback = void Function(Task, bool);

class ToDoList extends StatelessWidget {
  ToDoList({@required this.tasks, this.onTodoToggle});


  final List<Task> tasks;
 // final List<Todo> todos;
  final ToggleTodoCallback onTodoToggle;

  Widget _buildItem(BuildContext context, int index) {

    final task = tasks[index];
    //tasks = dbProvider.getTask()
    return CheckboxListTile(
      value: task.isDone,
      title: Text(task.title),
      onChanged: (bool isChecked) {
        onTodoToggle(task, isChecked);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: tasks.length,
    );
  }
}

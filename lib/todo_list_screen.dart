import 'package:flutter/material.dart';
import 'package:todo_list/Database.dart';
import 'package:todo_list/TaskModel.dart';

import 'package:todo_list/new_todo_dialog.dart';
import 'package:todo_list/todo_list.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = DBProvider.db.getTasks();

  _toggleTodo(Task task, bool isChecked) {
    setState(() {
      task.isDone = isChecked;
    });
  }

  _addTodo() async {
    final task = await showDialog<Task>(
      context: context,
      builder: (BuildContext context) {
        return NewTodoDialog();
      },
    );

    if (task != null) {
      setState(() {
        tasks.add(task);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: ToDoList(
        tasks: tasks,
        onTodoToggle: _toggleTodo,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}

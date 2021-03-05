
import 'package:flutter/material.dart';
import 'package:todo_list/Database.dart';
import 'package:todo_list/TaskModel.dart';

import 'package:todo_list/new_todo_dialog.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {

  _addTodo() async {
    final task = await showDialog<Task>(
      context: context,
      builder: (BuildContext context) {
        return NewTodoDialog();
      },
    );

    if (task != null) {
      setState(() {
        DBProvider.db.addTask(task);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: DBProvider.db.getTasks(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Task item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBProvider.db.deleteTask(item.id);
                  },
                  child: ListTile(
                      title: Text(item.taskDescription),
                      trailing: Checkbox(
                        onChanged: (bool value) {
                          DBProvider.db.doneOrUndone(item);
                          setState(() {});
                        },
                        value: item.isDone,
                      ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addTodo(),
      ),
    );
  }
}
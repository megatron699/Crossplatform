import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:todo_list/todo_list_screen.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      home: TodoListScreen(),
    );
  }
}
/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/todo_list_screen.dart';
import 'package:flutter/';
import 'Database.dart';
import 'TaskModel.dart';

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("ToDoList")),
    body: FutureBuilder<List<Task>>(
      future: DBProvider.db.getTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Task item = snapshot.data[index];
              return ListTile(
                title: Text(item.tittle),
                leading: Text(item.id.toString()),
                trailing: Checkbox(
                  onChanged: (bool value) {
                    DBProvider.db.doneOrUndone(item);
                    setState(() {});
                  },
                  value: item.isDone,
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
      onPressed: () async {
        Task rnd = testTasks[math.Random().nextInt(testTasks.length)];
        await DBProvider.db.newTask(rnd);
        setState(() {});
      },
    ),
  );
}
*/

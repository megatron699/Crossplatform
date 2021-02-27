import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/TaskModel.dart';


class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;
  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ToDoListDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Task ("
          "id INTEGER PRIMARY KEY,"
          "task_description TEXT,"
          "is_done BIT"
          ")");
    });
  }

  newTask(Task newTask) async {
    final db = await database;
    var res = await db.insert("Task", newTask.toJson());
    return res;
  }
  getTasks() async {
    final db = await database;
    var res = await db.query("Task").then((value) { return value.isNotEmpty ?
        value.map((c) => Task.fromJson(c)).toList() : [];});
    /*List<Task> list =
     res.isNotEmpty ? res.map((c) => Task.fromJson(c)).toList() : [];
    return list;*/
  }
  updateTask(Task newTask) async {
    final db = await database;
    var res = await db.update("Task", newTask.toJson(),
        where: "id = ?", whereArgs: [newTask.id]);
    return res;
  }
  deleteTask(int id) async {
    final db = await database;
    db.delete("Task", where: "id = ?", whereArgs: [id]);
  }

  doneOrUndone(Task task) async {
    final db = await database;
    Task done = Task(
        id: task.id,
        title: task.title,
        isDone: !task.isDone);
    var res = await db.update("Task", done.toJson(),
        where: "id = ?", whereArgs: [task.id]);
    return res;
  }
}



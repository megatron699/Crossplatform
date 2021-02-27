import 'dart:convert';
import 'package:database/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/Database.dart';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    this.id,
    this.title,
    this.isDone,
  });

  String id;
  String title;
  bool isDone;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    title: json["tittle"],
    isDone: json["is_done"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tittle": title,
    "is_done": isDone,
  };

}

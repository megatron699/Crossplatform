import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    this.id,
    this.taskDescription,
    this.isDone,
  });

  int id;
  String taskDescription;
  bool isDone;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    taskDescription: json["task_description"],
    isDone: json["is_done"] == 0 ? false : true,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_description": taskDescription,
    "is_done": isDone,
  };

}

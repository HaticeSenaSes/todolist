import 'dart:convert';

class TodoModel {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  const TodoModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'todo': todo,
        'completed': completed,
        'userId': userId,
      };

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int,
      todo: map['todo'] as String,
      completed: map['completed'] as bool,
      userId: map['userId'] as int,
    );
  }

  String toJson() => json.encode(toMap());
}

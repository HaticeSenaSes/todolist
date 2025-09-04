import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/model/todomodel.dart';

class TodoService {
  final String url = 'https://dummyjson.com/todos/';
  final String addUrl = 'https://dummyjson.com/todos/add';

  Future<List<TodoModel>> getTodos() async {
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      throw Exception('Todos fetch failed: ${res.statusCode}');
    }
    final decoded = jsonDecode(res.body) as Map<String, dynamic>;
    final list = (decoded['todos'] as List).cast<Map<String, dynamic>>();
    return list.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<String> addTodo(TodoModel newTodo) async {
    final response = await http.post(
      Uri.parse(addUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(newTodo.toJson()),
    );

    if (kDebugMode) {
      print(response.body);
    }

    return response.body;
  }
}

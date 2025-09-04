// lib/screens/home.dart
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todolist/constants/color.dart';
import 'package:todolist/model/todomodel.dart';
import 'package:todolist/screens/add_new_task.dart';
import 'package:todolist/service/todo_service.dart';
import 'package:todolist/todoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoService _todoService = TodoService();
  late final Future<List<TodoModel>> _todosFuture;

  @override
  void initState() {
    super.initState();
    _todosFuture = _todoService.getTodos();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            children: [
              // Header
              Container(
                width: deviceWidth,
                height: deviceHeight / 3,
                decoration: const BoxDecoration(
                  color: Color(0xFF4A3780),
                  image: DecorationImage(
                    image: AssetImage("lib/assets/images/header.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: Text(
                        "October 20, 2022",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "My Todo List",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: FutureBuilder<List<TodoModel>>(
                    future: _todosFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Hata: ${snapshot.error}'));
                      }

                      final all = snapshot.data ?? [];
                      final active = all.where((t) => !t.completed).toList();
                      final done = all.where((t) => t.completed).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: active.length,
                              itemBuilder: (_, i) => ToDoItem(task: active[i]),
                            ),
                          ),

                          const SizedBox(height: 12),
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 4, bottom: 8),
                                  child: Text(
                                    "Completed",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      itemCount: done.length,
                                      itemBuilder: (_, i) =>
                                          ToDoItem(task: done[i]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A3780), 
                      foregroundColor: Colors.white, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ), // Yükseklik
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              AddNewTaskScreen(addNewTask: (_) {}),
                        ),
                      );
                    },
                    child: const Text(
                      "Add New Task",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

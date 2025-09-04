import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todolist/constants/color.dart';
import 'package:todolist/constants/tasktype.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/model/todomodel.dart';
import 'package:todolist/service/todo_service.dart';

class AddNewTaskScreen extends StatefulWidget {
  final void Function(Task newTask) addNewTask;
  const AddNewTaskScreen({super.key, required this.addNewTask});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TodoService todoService = TodoService();

  TaskType taskType = TaskType.note;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight / 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF4A3780),
                  image: DecorationImage(
                    image: AssetImage("lib/assets/images/header.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 30, color: Colors.white),
                    ),
                    const Expanded(
                      child: Text(
                        "Add New Task",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), 
                  ],
                ),
              ),

              // Text Tile
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Task Title",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),

              // Category
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 600),
                            content: Text("Category is selected"),
                          ),
                        );
                        setState(() => taskType = TaskType.note);
                      },
                      child: Image.asset("lib/assets/images/Category.png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 600),
                            content: Text("Category is selected"),
                          ),
                        );
                        setState(() => taskType = TaskType.calender);
                      },
                      child: Image.asset("lib/assets/images/Category (1).png"),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 600),
                            content: Text("Category is selected"),
                          ),
                        );
                        setState(() => taskType = TaskType.contest);
                      },
                      child: Image.asset("lib/assets/images/Category (2).png"),
                    ),
                  ],
                ),
              ),

              // User ID & Time
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text("User ID", style: TextStyle(fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: userIdController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Time", style: TextStyle(fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: timeController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Description
              const SizedBox(height: 10),
              const Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 200,
                  child: TextField(
                    controller: descriptionController,
                    expands: true,
                    maxLines: null,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A3780),
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      elevation: 0,
                    ),
                    onPressed: () {
                      saveTodo();

                      final newTask = Task(
                        type: taskType,
                        title: titleController.text,
                        description: descriptionController.text,
                        isCompleted: false,
                      );

                      widget.addNewTask(newTask);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  void saveTodo() {
    final todoText = titleController.text.trim();
    final userText = userIdController.text.trim();

    final int parsedUserId = int.tryParse(userText) ?? 0;

    final newTodo = TodoModel(
      id: -1,
      todo: todoText,
      completed: false,
      userId: parsedUserId,
    );

    todoService.addTodo(newTodo);
  }
}

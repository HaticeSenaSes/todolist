import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todolist/constants/color.dart';
import 'package:todolist/constants/tasktype.dart';
import 'package:todolist/model/task.dart';

class AddNewTaskScreen extends StatefulWidget {
  final void Function(Task newTask) addNewTask;
  const AddNewTaskScreen({super.key, required this.addNewTask});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TaskType taskType = TaskType.note;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: deviceWidth,
                  height: deviceHeight / 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A3780),
                    image: const DecorationImage(
                      image: AssetImage("lib/assets/images/header.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.white,
                        ),
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
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Task Title",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Category",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 600),
                              content: Text("Category is selected"),
                            ),
                          );
                          setState(() {
                            taskType = TaskType.note;
                          });
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
                          setState(() {
                            taskType = TaskType.calender;
                          });
                        },
                        child: Image.asset(
                          "lib/assets/images/Category (1).png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 600),
                              content: Text("Category is selected"),
                            ),
                          );
                          setState(() {
                            taskType = TaskType.contest;
                          });
                        },
                        child: Image.asset(
                          "lib/assets/images/Category (2).png",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    // <<< DÜZELTME: tek child olacak, o da Column
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: TextField(
                                    controller: dateController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Time",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: TextField(
                                    controller: timeController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: TextField(
                          controller: descriptionController,
                          expands: true,
                          maxLines: null,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Task newTask = Task(
                            type: taskType,
                            title: titleController.text,
                            description: descriptionController.text,
                            isCompleted: false,
                          );
                          widget.addNewTask(newTask);
                          Navigator.pop(context);
                        },
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

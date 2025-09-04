import 'package:flutter/material.dart';
import 'package:todolist/model/todomodel.dart';

class ToDoItem extends StatefulWidget {
  final TodoModel task;
  const ToDoItem({super.key, required this.task});

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.completed; 
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isChecked ? Colors.grey.shade300 : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("lib/assets/images/Category.png"),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.todo,
                    style: TextStyle(
                      decoration:
                          isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text("User: ${widget.task.userId}"),
                ],
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: (val) {
                setState(() {
                  isChecked = val ?? false; // modeli değiştirmiyoruz
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todolist/constants/tasktype.dart';
import 'package:todolist/model/task.dart';

class ToDoItem extends StatefulWidget {
  final Task task;
  const ToDoItem({super.key, required this.task});

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.isCompleted ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.task.type == TaskType.note
                ? Image.asset("lib/assets/images/Category.png")
                : widget.task.type == TaskType.contest
                ? Image.asset("lib/assets/images/Category (1).png")
                : Image.asset("lib/assets/images/Category (2).png"),
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.task.title,
                    style: TextStyle(
                      decoration: widget.task.isCompleted 
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                      fontWeight: FontWeight.bold, 
                      fontSize: 15),
                  ),
                  Text(widget.task.description, 
                  style: TextStyle(
                    decoration: widget.task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                  ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: (val) => {
                setState(() {
                  widget.task.isCompleted = !widget.task.isCompleted;
                  isChecked = val!;
                }),
              },
            ),
          ],
        ),
      ),
    );
  }
}

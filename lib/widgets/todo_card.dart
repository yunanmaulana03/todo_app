import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/shared/theme.dart';

class TodoCard extends StatefulWidget {
  // create variable that a todocard will receive data for
  final int id;
  final String title;
  final DateTime creationDate;
  bool isChecked;
  final Function insertFunction;
  final Function deleteFunction;

  TodoCard({
    Key? key,
    required this.id,
    required this.title,
    required this.creationDate,
    required this.isChecked,
    required this.insertFunction, // it will handle the changes in checkbox
    required this.deleteFunction, // it will handle the delete button function
  }) : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    // create a local todo
    var anotherTodo = Todo(
        id: widget.id,
        title: widget.title,
        creationDate: widget.creationDate,
        isChecked: widget.isChecked);
    return Container(
      margin: EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 10,
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: kBlue,
        ),
      ),
      child: Row(
        children: [
          // this will be the checkbox
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Checkbox(
              value: widget.isChecked,
              onChanged: (bool? value) {
                setState(() {
                  widget.isChecked = value!;
                });
                // change teh value of anotherTodo's isCheck
                anotherTodo.isChecked = value!;
                // insert it to database
                widget.insertFunction(anotherTodo);
              },
            ),
          ),
          // this will be the title and date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd MMM yyyy - hh:mm aaa')
                      .format(widget.creationDate),
                  style: blackTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: light,
                  ),
                ),
              ],
            ),
          ),
          // this will be the delete button
          IconButton(
            onPressed: () {
              // add delete method
              widget.deleteFunction(anotherTodo);
            },
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

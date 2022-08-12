import 'package:flutter/material.dart';
import 'package:todo_app/shared/theme.dart';

import '../models/todo_model.dart';

class UserInput extends StatelessWidget {
  final textController = TextEditingController();
  final Function insertFunction; // this will receive the addItem function
  UserInput({Key? key, required this.insertFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      // color: Colors.blue,
      child: Row(
        children: [
          // this will be the input box
          Expanded(
            child: Container(
              width: 272,
              height: 55,
              margin: EdgeInsets.only(
                left: 10,
                bottom: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: kBlue),
                borderRadius: BorderRadius.circular(17),
              ),
              child: TextField(
                // add controller here
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Add new todo',
                  border: InputBorder.none,
                ),
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: light,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          // this will be the button
          GestureDetector(
            onTap: () {
              // create a todo
              var myTodo = Todo(
                title: textController.text,
                creationDate: DateTime.now(),
                isChecked: false,
              );
              // pass this to the insertFunction as parameter
              insertFunction(myTodo);
            },
            child: Container(
              width: 83,
              height: 55,
              margin: EdgeInsets.only(
                right: 10,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: kBlue,
                borderRadius: BorderRadius.circular(17),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 13,
              ),
              child: Text(
                'Add',
                style: whiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

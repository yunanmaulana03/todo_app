import 'package:flutter/material.dart';
import 'package:todo_app/models/db_model.dart';
import 'package:todo_app/shared/theme.dart';
import '../models/todo_model.dart';
import '../widgets/user_input.dart';
// import '../widgets/todo_card.dart';
import '../widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // we have to create our functions here, where the two widgets can communicate
  // create a database object so we can access database functions
  var db = DatabaseConnect();

  // function to add todo
  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  // functions to delete todo
  void deleteItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Todo App',
                    style: blueTextStyle.copyWith(
                      fontSize: 40,
                      fontWeight: regular,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'What do you do today?',
                    style: blueTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: light,
                    ),
                  )
                ],
              )),
          // we will add our widgers here.
          TodoList(
            insertFunction: addItem,
            
            deleteFunction: deleteItem,
          ),
          UserInput(
            insertFunction: addItem,
          ),
        ],
      ),
    );
  }
}

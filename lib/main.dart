import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/splash_screen.dart';
// import 'models/todo_model.dart';
// import 'models/db_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // sample data
  // var db = DatabaseConnect();
  // // insert a sample todo
  // await db.insertTodo(Todo(
  //     title: 'this is sample todo',
  //     creationDate: DateTime.now(),
  //     isChecked: false));
  // print(await db.getTodo());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
      },
    );
  }
}

import 'dart:async';

import 'package:sqflite/sqflite.dart'; // sqflite for database
import 'package:path/path.dart'; // the path package
import 'todo_model.dart'; // the todo model we created before

class DatabaseConnect {
  Database? _database;

  // create a getter and open a connection to database
  Future<Database> get database async {
    // this is the location of our database in device. ex - data/data/ ....
    final dbpath = await getDatabasesPath();
    // this is the name of our database.
    const dbname = 'todo.db';
    // this joins the dbpath and dbname and creates a full path for database.
    // ex - data/data/todo.db
    final path = join(dbpath, dbname);

    // open the connection
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    // we will create the _createDB function separately

    return _database!;
  }

  // the _create db function
  // this creates Tables in our database
  Future<void> _createDB(Database db, int version) async {
    // make sure the columns we create in our table match the todo_model field.
    await db.execute('''
CREATE TABLE todo(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  creationDate TEXT,
  isChecked INTEGER
)''');
  }

  // function to add data into our database
  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    // insert the todo
    await db.insert(
      'todo', // the name our table
      todo.toMap(), // the function we created in our todo_model
      conflictAlgorithm:
          ConflictAlgorithm.replace, // this will replace the duplicate entry
    );
  }

  // function to delete a todo from our database
  Future<void> deleteTodo(Todo todo) async {
    final db = await database;
    // delete the todo from database based on its id.
    await db.delete(
      'todo', // the ame our table
      where: 'id == ?', // this condition will check for id in todo list
      whereArgs: [todo.id],
    );
  }

  // function to fetch all the todo data from our database
  Future<List<Todo>> getTodo() async {
    final db = await database;
    // query the database and save the todo as list of maps
    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy: 'id DESC',
     ); // this will order the list by id in descending order. so the latest toto will be displayed on top.
      // convert the items dorm list of maps to list of todo
      return List.generate(
        items.length, 
        (i) => Todo(
          id : items[i]['id'], 
          title: items[i]['title'],
          creationDate: DateTime.parse(items[i]['creationDate']),
          //items[i]['creationDate'], // this is in Text format right now. and convert it to datetime format
          isChecked: items[i]['isChecked'] == 1 ? true : false, // this will convert the integer to boolean. 1 = true, 0 = false.
        ),
    );
  }
}

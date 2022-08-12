import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/shared/theme.dart';
import '../models/db_model.dart';
import '../widgets/todo_card.dart';

class TodoList extends StatelessWidget {
  // to pass down to todocard, first our todolist have to receive the functions
  final Function insertFunction;
  final Function deleteFunction;
  // create an object of database connect
  final db = DatabaseConnect();

  TodoList(
      {Key? key, required this.insertFunction, required this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: db.getTodo(),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            var data = snapshot
                .data; // this is the data we have to show. (list of todo)
            var datalength = data!.length;
            return datalength == 0
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/img_notfound.png',
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'No Data Found',
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ))
                : ListView.builder(
                    itemCount: datalength,
                    itemBuilder: (context, i) => TodoCard(
                      id: data[i].id,
                      title: data[i].title,
                      creationDate: data[i].creationDate,
                      isChecked: data[i].isChecked,
                      insertFunction: insertFunction,
                      deleteFunction: deleteFunction,
                    ),
                  );
          }),
    );
  }
}

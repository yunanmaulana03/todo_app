class Todo {
  int? id;
  final String title;
  DateTime creationDate;
  bool isChecked;

  // create the constructor

  Todo(
      {this.id,
      required this.title,
      required this.creationDate,
      required this.isChecked});

  // to save data in database we need to convert a map
  // create function

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'creationDate': creationDate
          .toString(), // sqflite database doesn't suppport the datetime type so we will convert to save it as Text
      'isChecked': isChecked
          ? 1
          : 0, // it doesn't support the boolean either,so we save that as integer
    };
  }

  // this function is for debugging only
  @override
  String toString() {
    return 'Todo(id : $id, title : $title, creationDate : $creationDate, isCheked : $isChecked)';
  }
}

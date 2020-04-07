import 'package:todoapp/models/todo.dart';

class TodoViewModel {
  Todo _todo;
  TodoViewModel(todo): _todo = todo;

  int get id {
    return _todo.id;
  }

  String get name {
    return _todo.name;
  }

  int get priority {
    return _todo.priority;
  }

  String get date {
    return _todo.date;
  }

}

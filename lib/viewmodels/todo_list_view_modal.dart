import 'package:flutter/cupertino.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/services/database_helper.dart';
import 'package:todoapp/viewmodels/todo_view_model.dart';

class TodoListViewModel with ChangeNotifier{
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<TodoViewModel> todos = List<TodoViewModel>();

  void populateTodos() async {
    List<Todo> todoList = await _databaseHelper.getTodoList();
    this.todos = todoList.map((todo) => TodoViewModel(todo)).toList();
    notifyListeners();
  }

  Future<int> insertTodo(String name,String date, int priority) async {
    try {
      var result = await _databaseHelper.insertTodo(Todo(name: name, date: date, priority: priority));
      populateTodos();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
 }


  Future<int> updateTodo(int id, String name,String date, int priority) async {
    try {
      var result = await _databaseHelper.updateTodo(Todo(id: id,name: name, date: date, priority: priority));
      populateTodos();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
 }

  Future<int> deleteTodo(int id) async {
    try {
      var result = await _databaseHelper.deleteTodo(Todo(id: id));
      populateTodos();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
 }
}

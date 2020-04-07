import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:todoapp/models/todo.dart';

class DatabaseHelper {
  static DatabaseHelper _instance = DatabaseHelper._internal();
  static Database _database;

  factory DatabaseHelper() {
    if(_instance == null) {
      DatabaseHelper._internal();
    }
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var notesDatabase =  await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  Future<Database> get database async {
    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, priority INTEGER, date TEXT)');
  }

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.database;
    var result = db.query('todos', orderBy: "priority ASC");
    return result;
  }



  Future<List<Todo>> getTodoList() async {
    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;
    List<Todo> todoList = List<Todo>();

    for(int i = 0; i < count; i++) {
      todoList.add(Todo.fromMap(todoMapList[i]));
    }
    return todoList;
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await this.database;
    var result = await db.insert('todos', todo.toMap());
    return result;
  }

  Future<int> updateTodo(Todo todo) async {
    Database db = await this.database;
    var result = await db.update('todos', todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodo(Todo todo) async {
    Database db = await this.database;
    var result = await db.delete('todos', where: 'id=?', whereArgs: [todo.id]);
    return result;
  }

}

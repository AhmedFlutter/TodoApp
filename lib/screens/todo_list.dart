import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/shared/screen_arguments.dart';
import 'package:todoapp/viewmodels/todo_list_view_modal.dart';
import 'package:todoapp/shared/functions.dart';
import 'package:todoapp/viewmodels/todo_view_model.dart';


class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoListViewModel>(context, listen: false).populateTodos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Todo List')),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/todo',
            arguments: ScreenArguments(title: "Add Todo", todoViewModel: TodoViewModel(Todo(id: 0, name: '', date: '', priority: 0)))
          );
        }
      ),
      body: Consumer<TodoListViewModel>(
        builder: (context, todoList, child) {
           return ListView.builder(
              itemCount: todoList.todos.length,
              itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(todoList.todos[index].name),
                  subtitle: Text(todoList.todos[index].date),
                  leading: CircleAvatar(
                    child: Icon(Icons.arrow_right),
                    backgroundColor: getPriorityColor(todoList.todos[index].priority),
                  ),
                  trailing: GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () async {
                      var result = await todoList.deleteTodo(todoList.todos[index].id);
                      if (result != null) {
                        showSnackBar("Todo has been deleted Successfully", context);
                      }
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/todo',
                      arguments: ScreenArguments(title: "Update Todo", todoViewModel: todoList.todos[index])
                    );
                  },
                ),
              );
            },
          );
        }
      )
    );
  }
}

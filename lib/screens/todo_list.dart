import 'package:flutter/material.dart';
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

  TodoListViewModel todoListViewModel = TodoListViewModel();

  @override
  void initState() {
    super.initState();
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
      body: StreamBuilder(
        stream: todoListViewModel.populateTodos(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          var todoList = snapshot.data;
          return snapshot.data == null ? Center(child: CircularProgressIndicator()) : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(todoList[index].name),
                  subtitle: Text(todoList[index].date),
                  leading: CircleAvatar(
                    child: Icon(Icons.arrow_right),
                    backgroundColor: getPriorityColor(todoList[index].priority),
                  ),
                  trailing: GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () async {
                      var result = await todoListViewModel.deleteTodo(todoList[index]);
                      if (result != null) {
                        showSnackBar("Todo has been deleted Successfully", context);
                      }
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/todo',
                      arguments: ScreenArguments(title: "Update Todo", todoViewModel: todoList[index])
                    );
                  },
                ),
              );
            },
          );
        },
      ),

    );
  }
}

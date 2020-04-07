import 'package:flutter/material.dart';
import 'package:todoapp/screens/todo_form.dart';
import 'package:todoapp/screens/todo_list.dart';
import 'package:todoapp/shared/screen_arguments.dart';

class RouteGenerator {

    final RouteFactory onGenerateRoute = (settings) {
      final ScreenArguments args = settings.arguments;
      switch (settings.name) {
        case "/":
          return MaterialPageRoute(
            builder: (_) {
              return TodoList();
            }
          );
        case "/todo":
          return MaterialPageRoute(
            builder: (_) {
              return TodoForm(title: args.title, todoViewModel: args.todoViewModel);
            }
          );
          break;
        default:
        return MaterialPageRoute(
            builder: (_) {
              return TodoList();
            }
        );
      }
    };

}

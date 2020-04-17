import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:todoapp/functions/route_generator.dart';
// import 'package:todoapp/viewmodels/todo_list_view_modal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Todo App",
        initialRoute: '/',
        onGenerateRoute: RouteGenerator().onGenerateRoute,
        theme: ThemeData(
          primarySwatch: Colors.amber
        ),
    );
  }
}

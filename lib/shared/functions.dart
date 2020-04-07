import 'package:flutter/material.dart';

int priorityTextToInt(String priority) {
  switch (priority) {
    case "High":
      return 0;
      break;
    case "Low":
      return 1;
      break;
    default:
      return 0;
  }
}

String priorityIntToText(int priority) {
    switch (priority) {
    case 0:
      return "High";
      break;
    case 1:
      return "Low";
      break;
    default:
      return "High";
  }
}

MaterialColor getPriorityColor(int priority) {
  switch (priority) {
    case 0:
      return Colors.red;
      break;
    case 1:
      return Colors.yellow;
    default:
      return Colors.red;
  }
}

void showAlertDialog(String title, String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok")
        )
      ],
    )
  );
}

void showSnackBar(String message, BuildContext context) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    )
  );
}

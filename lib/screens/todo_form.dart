import 'package:flutter/material.dart';
import 'package:todoapp/viewmodels/todo_list_view_modal.dart';
import 'package:todoapp/viewmodels/todo_view_model.dart';
import 'package:todoapp/shared/constants.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:todoapp/shared/functions.dart';


class TodoForm extends StatefulWidget {
  final String title;
  final TodoViewModel todoViewModel;

  TodoForm({
    Key key,
    @required this.title,
    @required this.todoViewModel
  }) : super(key: key);

  @override
  _TodoFormState createState() => _TodoFormState(title, todoViewModel);
}

class _TodoFormState extends State<TodoForm> {
  String title;
  TodoViewModel todoViewModel;
  TextEditingController todoName = TextEditingController();
  TextEditingController todoDate = TextEditingController();
  String dropdownValue = 'High';
  List<String> priority = ['High', 'Low'];
  TodoListViewModel todoListViewModel = TodoListViewModel();

  final _formKey = GlobalKey<FormState>();
  _TodoFormState(this.title, this.todoViewModel);

  @override
  void initState() {
    todoName.text = todoViewModel.name;
    todoDate.text = todoViewModel.date;
    dropdownValue = priorityIntToText(todoViewModel.priority);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(this.title)),
      ),
      body: ListView(
        children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: todoName,
                      validator: (value) => value.isEmpty ? "Please provide a Todo Name": null,
                      decoration: textInputDecoration.copyWith(hintText: "Todo Name"),
                    ),
                    SizedBox(height: 20.0),
                    DateTimeField(
                      initialValue: DateTime.tryParse(todoViewModel.date),
                      controller: todoDate,
                      validator: (date) => date == null  ? "Please provide a Todo Date": null,
                      decoration: textInputDecoration.copyWith(hintText: "Todo Date"),
                      format: DateFormat("yyyy-MM-dd"),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      decoration: textInputDecoration,
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: priority
                        .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 45.0,
                      child: RaisedButton(
                        onPressed: () async {
                          if(_formKey.currentState.validate()) {
                            var priorityInt = priorityTextToInt(dropdownValue);
                            if (todoViewModel.id == 0) {
                              var result =  await todoListViewModel.insertTodo(todoName.text, todoDate.text, priorityInt);
                              if (result != null) {
                                Navigator.pop(context);
                                showAlertDialog("Info", "Todo has been added Successfully", context);
                              }
                            }
                            else {
                              var result =  await todoListViewModel.updateTodo(todoViewModel.id,todoName.text, todoDate.text, priorityInt);
                              if (result != null) {
                                Navigator.pop(context);
                                showAlertDialog("Info", "Todo has been updated Successfully", context);
                              }
                            }
                          }
                        },
                        color: Colors.amber,
                        child: Icon(Icons.keyboard_arrow_right,size: 40.0,),
                      ),
                    ),
                  ],
                )
              )
          )
        ],
      ),

    );
  }
}

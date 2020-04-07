class Todo{
  int id;
  String name;
  String date;
  int priority;

  Todo({this.id, this.name, this.date, this.priority});

  Todo.fromMap(Map<String,dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.date = map['date'];
    this.priority  = map['priority'];
  }

  Map<String, dynamic> toMap() {
    Map<String,dynamic> map = Map<String,dynamic>();
    if (this.id != null) {
      map['id'] = this.id;
    }
    map['name'] = this.name;
    map['date'] = this.date;
    map['priority'] = this.priority;
    return map;
  }
}

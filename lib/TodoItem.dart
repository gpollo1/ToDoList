class TodoItem {
  String title;
  bool done;

  TodoItem(this.title, {this.done = false});

  Map<String, dynamic> toMap() => {
    'title': title,
    'done': done,
  };

  static TodoItem fromMap(Map<String, dynamic> map) =>
      TodoItem(map['title'], done: map['done']);
}
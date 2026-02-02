import 'TodoItem.dart';

class TodoList {
  String name;
  List<TodoItem> items;

  TodoList({required this.name, List<TodoItem>? items})
      : items = items ?? [];

  Map<String, dynamic> toMap() => {
    'name': name,
    'items': items.map((e) => e.toMap()).toList(),
  };

  static TodoList fromMap(Map<String, dynamic> map) => TodoList(
    name: map['name'],
    items: (map['items'] as List)
        .map((e) => TodoItem.fromMap(e))
        .toList(),
  );
}
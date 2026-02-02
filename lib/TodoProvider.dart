import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TodoListModel.dart';
import 'TodoItem.dart';


class TodoProvider extends ChangeNotifier {
  List<TodoList> lists = [];
  int selectedIndex = 0;

  TodoProvider();

  TodoList get currentList {
    if (lists.isEmpty) {
      lists.add(TodoList(name: 'Lista 1'));
      selectedIndex = 0;
    } else if (selectedIndex >= lists.length) {
      selectedIndex = 0;
    }
    return lists[selectedIndex];
  }

  // Totali e completati della lista corrente
  int get currentTotal => currentList.items.length;
  int get doneCount =>
      currentList.items.where((item) => item.done).length;

  double get currentEfficiency =>
      currentTotal == 0 ? 0 : doneCount / currentTotal * 100;

  // Totale e percentuale globale tutte le liste
  double get efficiency {
    int totalTasks = lists.fold(0, (sum, l) => sum + l.items.length);
    int totalDone = lists.fold(
        0, (sum, l) => sum + l.items.where((item) => item.done).length);
    return totalTasks == 0 ? 0 : totalDone / totalTasks * 100;
  }

  int get totalCount => lists.fold(0, (sum, l) => sum + l.items.length);

  // AZIONI TASK
  void addItem(String title) {
    currentList.items.add(TodoItem(title));
    saveData();
    notifyListeners();
  }

  void toggleItem(int index) {
    currentList.items[index].done = !currentList.items[index].done;
    saveData();
    notifyListeners();
  }

  void removeItem(int index) {
    currentList.items.removeAt(index);
    saveData();
    notifyListeners();
  }

  void clearCurrentList() {
    currentList.items.clear();
    saveData();
    notifyListeners();
  }

  // AZIONI LISTA
  void addList(String name) {
    lists.add(TodoList(name: name));
    selectedIndex = lists.length - 1;
    saveData();
    notifyListeners();
  }

  void removeList(int index) {
    if (lists.isEmpty) return;

    lists.removeAt(index);

    if (lists.isEmpty) {
      lists.add(TodoList(name: 'Lista 1'));
      selectedIndex = 0;
    } else if (selectedIndex >= lists.length) {
      selectedIndex = lists.length - 1;
    }

    saveData();
    notifyListeners();
  }

  void selectList(int index) {
    if (index < 0 || index >= lists.length) return;
    selectedIndex = index;
    saveData();
    notifyListeners();
  }

  // IMMAGINI FIORE-
  String get flowerImage {
    if (currentTotal == 0) return 'assets/images/p1.png';
    int stage = (currentEfficiency / 10).ceil();
    stage = stage.clamp(1, 10);
    return 'assets/images/p$stage.png';
  }

  // SALVATAGGIO DATI
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = lists.map((l) => l.toMap()).toList();
    await prefs.setString('todo_lists', jsonEncode(data));
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('todo_lists');
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      lists = decoded.map((l) => TodoList.fromMap(l)).toList();
      if (lists.isEmpty) {
        lists.add(TodoList(name: 'Lista 1'));
        selectedIndex = 0;
      }
    } else {
      lists.add(TodoList(name: 'Lista 1'));
      selectedIndex = 0;
    }
    notifyListeners();
  }
}
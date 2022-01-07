import 'dart:developer';

import 'package:amplify_flutter/amplify.dart';

import '../models/Todo.dart';

class TodosRepo {
  Future<List<Todo>> getItems() async {
    try {
      final boxItems = await Amplify.DataStore.query(Todo.classType);
      return boxItems;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createItem(String name, String description) async {
    Todo newTodo = Todo(
      name: name,
      description: description.isNotEmpty ? description : null,
      isComplete: false,
    );

    try {
      await Amplify.DataStore.save(newTodo);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateItemComplete(Todo todo) async {
    Todo updatedTodo = todo.copyWith(isComplete: !todo.isComplete);
    try {
      await Amplify.DataStore.save(updatedTodo);
    } catch (e) {
      log('An error occurred while saving Todo: $e');

      rethrow;
    }
  }

  Future<void> deleteItem(Todo todo) async {
    try {
      await Amplify.DataStore.delete(todo);
    } catch (e) {
      log('An error occurred while deleting Todo: $e');

      rethrow;
    }
  }

  Stream observeItems() {
    return Amplify.DataStore.observe(Todo.classType);
  }
}

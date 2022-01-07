import 'package:todo_app/models/Todo.dart';

abstract class TodosEvent {}

class FetchTodosData extends TodosEvent {}

class TodoAdded extends TodosEvent {
  final String name;
  final String? description;

  TodoAdded({required this.name, this.description});
}

class TodoUpdated extends TodosEvent {
  final Todo todo;

  TodoUpdated({required this.todo});
}

class TodoDeleted extends TodosEvent {
  final Todo todo;

  TodoDeleted({required this.todo});
}
